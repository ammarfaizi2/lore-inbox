Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281541AbRLBRRl>; Sun, 2 Dec 2001 12:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281513AbRLBRRb>; Sun, 2 Dec 2001 12:17:31 -0500
Received: from cs6669235-16.austin.rr.com ([66.69.235.16]:25729 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281504AbRLBRRV>; Sun, 2 Dec 2001 12:17:21 -0500
Date: Sun, 2 Dec 2001 11:17:16 -0600 (CST)
From: Erik Elmore <lk@bigsexymo.com>
X-X-Sender: <lk@localhost.localdomain>
To: Andrew Morton <akpm@zip.com.au>
cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <3C0946C7.798208C3@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112021116190.13663-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen a couple of reports where ext3 appears to exacerbate
> the effects of poor hdparm settings.  What is your raw disk
> throughput, from `hdparm -t /dev/hda'?

`hdparm -t /dev/hda` reports:

# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 16.76 seconds =  3.82 MB/sec


Erik


