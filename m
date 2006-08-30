Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWH3IDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWH3IDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWH3IDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:03:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:31127 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750846AbWH3IDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:03:03 -0400
Date: Wed, 30 Aug 2006 10:02:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: zhiyi huang <hzy@cs.otago.ac.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ultra Sparc T1 port
In-Reply-To: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz>
Message-ID: <Pine.LNX.4.61.0608300956190.26677@yvahk01.tjqt.qr>
References: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using a Ubuntu port on Ultra Sparc T1.
> Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version 4.0.3 (Ubuntu
> 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006
> I have installed a module in the kernel. It is a RAM device driver. When my
> application calls ioctl on the device (/dev/dsm), I got the following log
> message:
>
> Aug 29 11:13:20 info-sf-03 kernel: [    3.603348] ioctl32(manager:18821):
> Unknown cmd fd(3) cmd(80047f00){00} arg(fffc3934) on /dev/dsm
>
> I check my module and found the control has not reached my module yet. I
> haven't got much clue why it happened and how to fix the problem. It works fine
> on Linux 2.6.8/i386, by the way.
> Thanks for help:)

I think you forgot to provide the source.


Jan Engelhardt
-- 
