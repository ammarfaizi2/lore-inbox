Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUJDRuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUJDRuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUJDRuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:50:40 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:51592 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268365AbUJDRub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:50:31 -0400
Date: Mon, 4 Oct 2004 19:47:00 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
Message-ID: <20041004174700.GB30858@thundrix.ch>
References: <9e47339104100220553c57624a@mail.gmail.com> <Pine.LNX.4.58.0410030824280.2325@skynet> <9e47339104100309468e6a64f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <9e47339104100309468e6a64f@mail.gmail.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Sun, Oct 03, 2004 at 12:46:51PM -0400, Jon Smirl wrote:
> But there does appear to be one other user of inter_module_...
> MTD driver for "M-Systems Disk-On-Chip Millennium Plus"
> mtd/devices/doc2001plus.c
> mtd/chips/cfi_cmdset_0001.c

nvidia and  ati use them  as well, it  seems. Not that I'd  care about
them, though. They can roll their own fixes as they decided to.

			     Tonnerre


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBYYyT/4bL7ovhw40RAjshAJoDTZMYem/X8V/BgpXjsRC5xoA8rQCfcniV
yZI/tZ+riNhxsO2IGtpjdxk=
=M3Ka
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
