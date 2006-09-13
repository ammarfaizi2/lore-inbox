Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWIMPqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWIMPqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWIMPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:46:54 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:29611 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1750968AbWIMPqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:46:54 -0400
From: Benjamin Schindler <bschindler@student.ethz.ch>
Organization: ETH =?iso-8859-1?q?Z=FCrich?=
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Soft Lockup detected on cpu#0
Date: Wed, 13 Sep 2006 17:45:29 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <4507B77F.1040907@student.ethz.ch> <1158157797.3768.26.camel@mindpipe>
In-Reply-To: <1158157797.3768.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1181196.bL5rAi2RHm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609131745.30082.bschindler@student.ethz.ch>
X-OriginalArrivalTime: 13 Sep 2006 15:46:52.0812 (UTC) FILETIME=[D552A4C0:01C6D74B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1181196.bL5rAi2RHm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I will certainly try. (I'll use the default gentoo-patchset - I assume this=
 is=20
ok since others seem to use it as well). But the problem is hard to=20
reproduce...

Thanks
Benjamin Schindler
On Wednesday 13 September 2006 16:29, Lee Revell wrote:
> On Wed, 2006-09-13 at 09:47 +0200, Benjamin Schindler wrote:
> > EIP is at log_do_checkpoint+0xa0/0x134
> >  EFLAGS: 00000202    Not tainted    (2.6.16/suspend2/r1 #4)
>
> Do you have the same problem without the suspend2 patch applied?
>
> Problems with out-of-tree patched kernels should be reported to the
> maintainer of the patches.
>
> Lee

--nextPart1181196.bL5rAi2RHm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFCCeZIExHgErho7kRAsIvAJ9h4uUfTGQfkYx9rFSEl4T7l2KubgCfSkL/
OeK33e4UUoSKUFsmzpyfDhU=
=SdFV
-----END PGP SIGNATURE-----

--nextPart1181196.bL5rAi2RHm--
