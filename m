Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314562AbSELP4F>; Sun, 12 May 2002 11:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSELP4E>; Sun, 12 May 2002 11:56:04 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:6662 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S314458AbSELP4E>; Sun, 12 May 2002 11:56:04 -0400
Date: Sun, 12 May 2002 17:55:57 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: <mcp@linux-systeme.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] NTFS 2.0.7a for Linux 2.4.18
In-Reply-To: <Pine.LNX.3.96.1020512040757.27097A-100000@fps>
Message-ID: <Pine.LNX.4.33.0205121752350.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sun, 12 May 2002 mcp@linux-systeme.de wrote:

> Yes, 2.4.18 + preempt and some other additional stuff.
> NTFS is a Module, happs with/without selecting debug feature in kernel
> config.

Preemption is adressed with 2.0.7b patch I just released. It should
compile cleanly and it seems to run as stable as with vanilla 2.4.18.
I tested it with 2.4.18-4 rml's patch (and nothing else).

Download as usually from:
http://linux-ntfs.sf.net/downloads.html

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

