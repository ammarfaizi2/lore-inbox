Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUIOQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUIOQvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIOQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:51:29 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:14803 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266643AbUIOQut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:50:49 -0400
Date: Wed, 15 Sep 2004 18:49:14 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Tomasz Rola <rtomek@cis.com.pl>
Cc: Andre Bonin <kernel@bonin.ca>, linux-kernel@vger.kernel.org
Subject: Re: PCI coprocessors
Message-ID: <20040915164914.GG24818@thundrix.ch>
References: <41483BD3.4030405@bonin.ca> <Pine.LNX.3.96.1040915164509.26011A-100000@pioneer.space.nemesis.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1040915164509.26011A-100000@pioneer.space.nemesis.pl>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 15, 2004 at 04:55:53PM +0200, Tomasz Rola wrote:
> After loading  a kernel into it  somehow, boot it with  nfs root and
> run the rest from nfs server  that would be provided by a host Intel
> machine.

I'd rather not do that via nfs. Rather some special "hostfs" port over
PCI.

But  anyway, reading  his original  post  he seems  to have  something
completely different  in mind than booting  a second PC on  his PC: to
boot a supportive processor..

			    Tonnerre

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBSHKJ/4bL7ovhw40RAt6sAKCr/ZIccnRtPkgwBFr7HNPp/+8PBACbBLYC
hWK+4bl3UsZ9TXhLGhE0zkU=
=Hqeu
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
