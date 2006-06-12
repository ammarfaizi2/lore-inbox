Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWFLUzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWFLUzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFLUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:55:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:9561 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751147AbWFLUzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:55:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id:from;
        b=accB1VDl1NRfla5WerdVaNX+OGT/ggr/FuuXeHXJern8YvhqCOQNSe2alSyI3S/MroNBI9q3rT4/dXkf5jIqt4NVEw5ftSFjpemwGC35PRfug1hcrN8WIb26qz1/CvPH9AtK3TGhJFPvlazXTHNSvBVxU+EzHxj1m6CjVxej3zA=
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] CRC ITU-T V.41
Date: Mon, 12 Jun 2006 22:59:19 +0200
User-Agent: KMail/1.8.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <200606121617.08791.IvDoorn@gmail.com> <200606121932.37990.IvDoorn@gmail.com> <Pine.LNX.4.61.0606122005060.7959@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606122005060.7959@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5491167.vtZXkXS8aq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606122259.22951.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5491167.vtZXkXS8aq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 12 June 2006 20:05, Jan Engelhardt wrote:
> >> so the rt2x00 driver will be converted to use this lib/ code?
> >
> >Yes. [...]
> >If this patch is is applied I'll immediately send the patch to netdev
> >to make rt2x00 use this library.
> >
> Is rt2x00 already in-kernel? AFAIK no, but correct me if I am wrong.

No not yet. It is only located in the wireless-dev tree from John Linville.
It has the d80211 stack as a dependency, and that stack is also
only found in the wireless-dev tree.

Ivo

--nextPart5491167.vtZXkXS8aq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEjdWqaqndE37Em0gRAgh6AJ4jpxoCUdrPulzQGk5uBJtoggHyJACfQe+Q
3nrCHbHn6x4PMUzzmguKKAM=
=LELy
-----END PGP SIGNATURE-----

--nextPart5491167.vtZXkXS8aq--
