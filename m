Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUBXVOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUBXVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:14:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262467AbUBXVOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:14:23 -0500
Date: Tue, 24 Feb 2004 22:14:20 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Message-ID: <20040224211420.GG26919@devserv.devel.redhat.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3DE@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3DE@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2004 at 04:02:34PM -0500, Mukker, Atul wrote:
> > > controllers and also a single code base, with a very small 
> > footprint patch -
> > > if at all required, to support various kernels.
> > 
> > I didn't say "no".  I'm just warning you that you've chosen a 
> > hard road
> > to hoe, particularly with the limited life of 2.4.
> 
> In my opinion, maintaining support for 2.4 drivers and adding new
> controllers to it would be crucial for a considerable time to come even

there is a difference between just adding a pci id and adding all new
features.

> Do we want to discover controllers and devices directed solely by kernel and
> should driver interfere a little bit.

I always considered the megaraid code here extremely hairy... I'd love to
see it go when we can 

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAO76rxULwo51rQBIRAloOAJ48gUOkwC2yYoL+BVZKh4I1/eUEGACfWUC2
10kwXztz+de1+aXhlXsI1V4=
=2OOj
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
