Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132014AbRCVNah>; Thu, 22 Mar 2001 08:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132015AbRCVNaR>; Thu, 22 Mar 2001 08:30:17 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:44651 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S132014AbRCVNaG>; Thu, 22 Mar 2001 08:30:06 -0500
Date: Thu, 22 Mar 2001 14:29:18 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Brian Dushaw <dushaw@munk.apl.washington.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt82c686b  and UDMA(100)
In-Reply-To: <Pine.LNX.4.30.0103220224160.3867-100000@munk.apl.washington.edu>
Message-ID: <Pine.LNX.4.32.0103221423240.12167-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Brian Dushaw wrote:

> And for the record:
>
> "hdparm -d1 -t -X69 /dev/hda" gives:

My current hdparm line looks like this:

hdparm -m16 -c1 -u1 -k1 -X69 /dev/...

With this, I can get 28.x MB/s instead of 15.y with just -X69.

Nils
-- 
 Nils Philippsen / Berliner Straﬂe 39 / D-71229 Leonberg // +49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@fht-esslingen.de / nils@redhat.de
   The use of COBOL cripples the mind; its teaching should, therefore, be
   regarded as a criminal offence.                  -- Edsger W. Dijkstra

