Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUFBMCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUFBMCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFBMCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:02:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58763 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262062AbUFBMBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:01:36 -0400
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200406021352.14561.ornati@fastwebnet.it>
References: <200406021116.35529.ornati@fastwebnet.it>
	 <20040602104900.GB32474@infradead.org>
	 <200406021352.14561.ornati@fastwebnet.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lk4Mrn3Xhu5vyspqNTjI"
Organization: Red Hat UK
Message-Id: <1086177686.2709.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 14:01:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lk4Mrn3Xhu5vyspqNTjI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> So if you want to use USB Mass Storage devices (that use SCSI emulation) =
you=20
> need also SCSI disk support (I have realized it when I've tried to mount=20
> one those USB devices, without success).

... but I only want to use USB cdroms ;)



--=-lk4Mrn3Xhu5vyspqNTjI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvcGWxULwo51rQBIRAszUAJ4/VKIKcJFFATKbCapgGgzO62j6dQCfdCfd
J9vTbbGHdcX7FT6lKfc05k8=
=q4Su
-----END PGP SIGNATURE-----

--=-lk4Mrn3Xhu5vyspqNTjI--

