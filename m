Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRKMRed>; Tue, 13 Nov 2001 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKMReX>; Tue, 13 Nov 2001 12:34:23 -0500
Received: from t2.redhat.com ([199.183.24.243]:48885 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S277431AbRKMReG>; Tue, 13 Nov 2001 12:34:06 -0500
Date: Tue, 13 Nov 2001 11:34:01 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols
Message-Id: <20011113113401.55b75a1b.reynolds@redhat.com>
In-Reply-To: <2349543194.1005671437@[10.132.113.67]>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
	<2349543194.1005671437@[10.132.113.67]>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="6Q72)M8=.L9hj,)g"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--6Q72)M8=.L9hj,)g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It was a dark and stormy night.  Suddenly "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk> began to type:

> Keith,
> 
> --On Tuesday, November 13, 2001 1:50 PM +1100 Keith Owens <kaos@ocs.com.au> 
> wrote:
> 
> > Hint: You are trying to load a module without a GPL compatible license
> >       and it has unresolved symbols.  The module may be trying to access
> >       GPLONLY symbols but the problem is more likely to be a coding or
> >       user error.  Contact the module supplier for assistance.
> >
> > Does anyone think that this message can be misunderstood by anybody
> > with the "intelligence" of the normal Windoze user?
> 
> Yes I think it can be misunderstood, and, perhaps more importantly, still
> points the user at GPLONLY when it's more likely to be a straightforward
> version mismatch. Better might be:
> 
> Hint: You are trying to load a module which has unresolved symbols. These
>       symbols may not be exported by this version of the kernel (perhaps
>       you have a version mismatch), or they may be exported GPLONLY,
>       (in which case they will not be available to your module which does
>       not carry a GPL compatible license). In either case, contact
>       the *only* module supplier for assistance; no one else can help you.
             ^^^^                                  ^^^^^^^^^^^^^^^^^^^^^^^^

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--6Q72)M8=.L9hj,)g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjvxWY0ACgkQWEn3bOOMcuqO7QCfXqBm/OojtxhhoajD9Gh7t8wl
aP8AnR4IC7nyBqr9VtZoFymI3eVNHgwb
=lgrw
-----END PGP SIGNATURE-----

--6Q72)M8=.L9hj,)g--

