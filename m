Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVCaLnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVCaLnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCaLnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:43:12 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:53454 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261371AbVCaLmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:42:51 -0500
Message-ID: <424BE242.1020302@arcor.de>
Date: Thu, 31 Mar 2005 13:42:58 +0200
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sean <seandarcy2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org> <424B79E6.90300@pobox.com> <20050331060201.GB25365@kroah.com>
In-Reply-To: <20050331060201.GB25365@kroah.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA960D4999227F6E03D8DACCA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA960D4999227F6E03D8DACCA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg KH schrieb:
> On Wed, Mar 30, 2005 at 11:17:42PM -0500, Jeff Garzik wrote:
> 
>>Should hopefully just be changing get-version.pl ...
> 
> 
> Nah, this simple patch to snapshot fixes it.
> 
> I've also generated the 2.6.12-rc1-bk3 snapshot and fixed up the
> directory on kernel.org so it should now work properly if you apply the
> patch.

Hi, have the incremental patches been fixes as well? Last is 2.6.11-bk9 to bk10...

-- 
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigA960D4999227F6E03D8DACCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCS+JCxU2n/+9+t5gRAiGCAKDylNr/qhKGn0/XTKucPlabh5G3HwCeMBMU
98g8F54/AeNs19jg5godwRs=
=nVRv
-----END PGP SIGNATURE-----

--------------enigA960D4999227F6E03D8DACCA--
