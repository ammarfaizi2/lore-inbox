Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWINNdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWINNdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWINNdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:33:18 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:48574 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750710AbWINNdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:33:17 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: "hard-safe -> hard-unsafe lock order detected" on rmmod
Date: Thu, 14 Sep 2006 15:33:28 +0200
User-Agent: KMail/1.9.4
References: <200609141513.52932.eike-kernel@sf-tec.de>
In-Reply-To: <200609141513.52932.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1180295.Xs9V8Dg5Jd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609141533.28209.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1180295.Xs9V8Dg5Jd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I wrote:
> rmmod dm_snapshot ohci_hcd snd_intel8x0 ide_cd ehci_hcd floppy
> ip6table_mangle iptable_nat iptable_mangle snd_seq snd_seq_device
> snd_pcm_oss edd

It's ide_cd.

Eike

--nextPart1180295.Xs9V8Dg5Jd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFCVooXKSJPmm5/E4RAutbAJ9k4TX+9Z36hw9UiDMzhsDCVJVr+ACfd44P
xfbZ3KLN5c329msaAEz68lA=
=C6Mq
-----END PGP SIGNATURE-----

--nextPart1180295.Xs9V8Dg5Jd--
