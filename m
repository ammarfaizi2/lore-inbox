Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSFPKvc>; Sun, 16 Jun 2002 06:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSFPKvb>; Sun, 16 Jun 2002 06:51:31 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:10641 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316106AbSFPKvb>; Sun, 16 Jun 2002 06:51:31 -0400
Date: Sun, 16 Jun 2002 06:52:50 -0400
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020616105250.GA919@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's interesting. What exactly was failing ? It'd be in everyones
> interests to get those bits pushed to Linus sooner.

This time it was tiobench with 32 threads.  The <sysrq Tasks>
and a few other details on the livelock are at:

http://home.earthlink.net/~rwhron/kernel/2.5.21-sysrq.txt

If the System.map file is useful, it is at:
http://home.earthlink.net/~rwhron/kernel/System.map-2.5.21.bz2

-- 
Randy Hron

