Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSELLZ3>; Sun, 12 May 2002 07:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSELLZ2>; Sun, 12 May 2002 07:25:28 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:2832 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S312590AbSELLZ0>; Sun, 12 May 2002 07:25:26 -0400
Date: Sun, 12 May 2002 13:25:18 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: <mcp@linux-systeme.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] NTFS 2.0.7a for Linux 2.4.18
In-Reply-To: <Pine.LNX.3.96.1020512040757.27097A-100000@fps>
Message-ID: <Pine.LNX.4.33.0205121323490.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sun, 12 May 2002 mcp@linux-systeme.de wrote:

> >Backported NTFS 2.0.7 from 2.5.x to 2.4.18 is available from linux-ntfs
> >project page:
> i've tried this, have a look:
[...]
> Yes, 2.4.18 + preempt and some other additional stuff.
> NTFS is a Module, happs with/without selecting debug feature in kernel
> config.

Thanks for the report. I'll add preemtion support in the 2.0.7b (or 2.0.8a
if Anton will make 2.0.8 first).

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

