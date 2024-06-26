      subroutine modisbrdf(p1,p2,p3,mu,np,rm,rp,brdfint)
      real p1,p2,p3,xmu,view
      real dts,dtv,dfs,dfv,dfi
      real rts,rtv,rfs,rfv,rfi,rpha
      real cts,ctv,cfi,cpha,ct0
      real sts,stv,sfi
      real tanti,tantv
      real cost,sint,tvar
      real rossthick,rosselt,lispars
      real angdist,angtemp,angover
      integer mu,np,k,j
      real rm(-mu:mu),rp(np),brdfint(-mu:mu,np)
      rts=acos(rm(0))
      pi=atan(1.)*4.
      if ((rts*180./pi).gt.75.) rts=75.*pi/180.
      do k=1,np
        do j=1,mu
            rtv=acos(rm(j))
            if ((rtv*180./pi).gt.65.) rtv=65.*pi/180.
            if (j.eq.mu) then
                rfi=rm(-mu)
            else
                rfi=rp(k)+rm(-mu)
            end if
            rfi=abs(rfi)
            cts=cos(rts)
            ctv=cos(rtv)
            sts=sin(rts)
            stv=sin(rtv)
            cfi=cos(rfi)
            sfi=sin(rfi)
            cpha=cts*ctv+sts*stv*cfi
            if (cpha.gt.1.0)  cpha=1.0
            if (cpha.lt.-1.0) cpha=-1.0
            rpha=acos(cpha)

            rosselt=(pi/2-rpha)*cpha+sin(rpha)
            rossthick=(rosselt/(cts+ctv))-pi/4.

            tanti=tan(rts)
            tantv=tan(rtv)

            angdist=tanti*tanti+tantv*tantv-2.*tanti*tantv*cfi
            angdist=sqrt(angdist)
    
            angtemp=1./cts+1./ctv
            !cost=2.*sqrt(angdist*angdist+tanti*tanti*tantv*tantv*sfi*sfi)
            cost=2.*sqrt(angdist*angdist+tanti*tanti*tantv
     &      *tantv*sfi*sfi)
            cost=cost/angtemp
            if (cost.ge.1.) cost=1.
            if (cost.le.-1.) cost=-1.
            tvar=acos(cost)
            sint=sqrt(1.-cost*cost)
            angover=(tvar-sint*cost)*angtemp/pi
            lispars=angover-angtemp+0.5*(1.+cpha)/cts/ctv
      
            brdfint(j,k)=p1+p2*rossthick+p3*lispars
            if (brdfint(j,k).lt.0.) then
                brdfint(j,k)=0.
                write(6,*) 'Warning negative reflectance'
                write(6,*) 'from the BRDF model.'
                write(6,*) 'set to 0.'
            endif
        end do
      end do
      return
      end
