Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWBFTcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWBFTcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWBFTcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:32:18 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:19872 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S932312AbWBFTcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:32:17 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
Date: Mon, 6 Feb 2006 20:31:58 +0100
User-Agent: KMail/1.7.2
Cc: Lee Revell <rlrevell@joe-job.com>, William Park <opengeometry@yahoo.ca>
References: <20060206034312.GA2962@node1.opengeometry.net> <1139200372.2791.208.camel@mindpipe>
In-Reply-To: <1139200372.2791.208.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13727098.yNjhM8V5PN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602062032.09159.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13727098.yNjhM8V5PN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Lee,

On Monday 06 February 2006 05:32, Lee Revell wrote:
> This is actually a problem in several areas of the kernel (it's the same
> for "Generic RTC" vs. the normal RTC) - I don't think the name "Generic"
> properly reflects that it will prevent more specific device support from
> working.

What about "Fallback $DEVICE" instead?

Regards

Ingo Oeser


--nextPart13727098.yNjhM8V5PN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD56Q5U56oYWuOrkARAvU/AJ9aPclAWRQKPDUmkAdXhDWRU8wm/gCgsmTf
gXrl2Rst97z/feLE06ACiKI=
=6X8h
-----END PGP SIGNATURE-----

--nextPart13727098.yNjhM8V5PN--
