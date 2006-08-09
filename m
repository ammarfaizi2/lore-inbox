Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWHITns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWHITns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHITns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:43:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:44937 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751331AbWHITns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:43:48 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,107,1154934000"; 
   d="asc'?scan'208"; a="114168172:sNHT60054211"
Subject: Announcing free software graphics drivers for Intel i965 chipset
From: Keith Packard <keith.packard@intel.com>
Reply-To: keith.packard@intel.com
To: linux-kernel@vger.kernel.org
Cc: keith.packard@intel.com, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UzCamDpC7sRHMdKfXW4P"
Organization: Intel Corp
Date: Wed, 09 Aug 2006 12:43:33 -0700
Message-Id: <1155152613.11104.119.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UzCamDpC7sRHMdKfXW4P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The Intel Open Source Technology Center graphics team is pleased to announc=
e
the immediate availability of free software drivers for the Intel=C2=AE 965
Express Chipset family graphics controller. These drivers include support
for 2D and 3D graphics features for the newest generation Intel graphics
architecture. The project Web site is http://IntelLinuxGraphics.org.

This release represents the start of a long term effort by Intel to work
with the X.org and Mesa communities to continuously improve and enhance
the drivers.  While these drivers represent significant work at both
Tungsten Graphics and Intel, as our first release of this code, they're
still in need of significant testing, tuning and bug fixing before
they'll be ready for production use. We're releasing them now to
demonstrate our ongoing commitment to providing free software drivers
for Intel hardware.

The Intel=C2=AE 965 Express Chipset represents the first product family tha=
t
implements fourth generation Intel graphics architecture. Designed to
support advanced rendering features in modern graphics APIs, this chipset
family includes support for programmable vertex, geometry, and fragment
shaders. By open sourcing the drivers for this new technology, Intel enable=
s
the open source community to experiment, develop, and contribute to the
continuing advancement of open source 3D graphics.

We would like to especially thank our partners at Tungsten Graphics - Alan
Hourihane and Keith Whitwell - for developing the new 3D driver and enhanci=
ng
the 2D driver to support the new hardware.=20

Intel has assembled a team within the Open Source Technology Center to
manage Intel graphics driver development going forward:

Development

        Eric Anholt <eric.anholt@intel.com>
        Guangdeng Liao <guangdeng.laio@intel.com>
        Keith Packard <keith.packard@intel.com>
        Zhenyu Wang <zhenyu.z.wang@intel.com>

Testing

        Gordon Jin <gordon.jin@intel.com>
        Shuang He <shuang.he@intel.com>
        Wang Wei <wei.z.wang@intel.com>
        Weiliang Chong <weiliang.chong@intel.com>
        Wu Nian <nian.wu@intel.com>

Following the release of this driver, future work will continue in the
public X.org and Mesa project source code repositories. The project Web sit=
e,
http://IntelLinuxGraphics.org, will serve as the central site for users of
Intel graphics hardware in open source operating systems.

--=20
keith.packard@intel.com

--=-UzCamDpC7sRHMdKfXW4P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2jrlQp8BWwlsTdMRAlBcAJsED+QiRKCCmlIJXoxFW6jkCg+m0QCcCCeu
EN40okHCHaiH8jczjHIHBo0=
=vcVn
-----END PGP SIGNATURE-----

--=-UzCamDpC7sRHMdKfXW4P--
