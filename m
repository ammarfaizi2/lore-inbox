Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUD1ULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUD1ULw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUD1UKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:10:35 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:36289 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S261981AbUD1TzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:55:21 -0400
Date: Wed, 28 Apr 2004 20:54:34 +0100
From: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Hinds <dhinds@sonic.net>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org
Subject: Re: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Message-ID: <20040428195434.GA27783@jsambrook>
Reply-To: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
References: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades> <20040319210720.J14431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20040319210720.J14431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 21:07 on Fri 19/03/04, rmk+lkml@arm.linux.org.uk masquerading as 'Russel=
l King' wrote:
> On Fri, Mar 19, 2004 at 03:14:54PM -0300, Marcelo Tosatti wrote:
> > It seems the problem reported by Silla Rizzoli is still present in 2.6.x
> > and 2.4.25 (both include the voltage interrogation patch by rmk).
> >=20
> > Daniel Ritz made some efforts to fix it, but did not seem to get it rig=
ht.=20
>=20
> And that effort is still going on.  Daniel and Pavel have been trying
> to find a good algorithm for detecting and fixing misconfigured TI
> interrupt routing, and this effort is still on-going.
>=20
> What would be useful is if Silla could test some of Daniel's patches
> and provide feedback.
>=20
> The latest 2.6 patch from Daniel is at:

Any movement on 2.4.x w.r.t this?
Even a patch to get back 2.4.23 functionality whihc worked fine here
would be good (need > 2.4.25 for XFS).

Regards,
Jonathan
>=20
> 	http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9.patch
>=20
> and I'll ask that feedback is sent to linux-pcmcia and not as a reply
> to this message (I'm just monitoring what's going on at present.)
>=20
> Essentially, this patch needs to be well tested before it goes into
> mainline.
>=20
> --=20
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
                  =20
 Jonathan Sambrook=20
Software  Developer=20
 Designer  Servers

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAkAv6SUOTbbpGXDwRAgmkAJ0WTe+XJMNBXdJnIy20L3nO70L9LQCfbTKt
QL/QgQYwBB1k0fiVu1OfFPk=
=Ng3J
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
