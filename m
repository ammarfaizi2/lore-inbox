Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272255AbTHNJZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTHNJZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:25:48 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:36047 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S272255AbTHNJZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:25:47 -0400
Date: Thu, 14 Aug 2003 12:25:40 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: linux-kernel@vger.kernel.org, "Sharma, Arun" <arun.sharma@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3
Message-ID: <20030814092540.GA7165@actcom.co.il>
References: <2C83850C013A2540861D03054B478C0601CF646D@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF646D@hasmsx403.iil.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2003 at 12:02:44PM +0300, Zach, Yoav wrote:
> The proposed patch solves a problem for interpreters that need to
> execute a non-readable file, which cannot be read in userland. To handle
> such cases the interpreter must have the kernel load the binary on its
> behalf.=20

In what scenarios does this occur?=20

> The patch is against linux-2.6.0-test3

Please send patches as inline text, unless they're really big. Thank
you.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/O1WUKRs727/VN8sRAnx6AKCwU27FTM1X+cKc3O+Cipks3jHQSQCfTA0R
2S5wCNpcTLiLB9/o2Gd1/+4=
=KZzT
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
