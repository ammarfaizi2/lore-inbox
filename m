Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTAAAmO>; Tue, 31 Dec 2002 19:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAAAmO>; Tue, 31 Dec 2002 19:42:14 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15015 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264938AbTAAAmN> convert rfc822-to-8bit; Tue, 31 Dec 2002 19:42:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.20 when accessing SVCDs
Date: Wed, 1 Jan 2003 01:50:13 +0100
User-Agent: KMail/1.4.3
References: <3E11B976.3010306@iku-ag.de>
In-Reply-To: <3E11B976.3010306@iku-ag.de>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Kurt Huwig <k.huwig@iku-ag.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301010150.13274.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 December 2002 16:36, Kurt Huwig wrote:

Hi Kurt,

> I got the attached oops when copying a file from a SVCD using cdfs-0.5c
> I mounted a SVCD using
> 	mount -t cdfs /dev/cdbrenner /cdbrenner
> using the cdfs driver from
> 	http://www.elis.rug.ac.be/~ronsse/cdfs/cdfs.html

> Any help would be appreciated.
Can you reproduce this w/o cdfs? I've heard alot of problems with cdfs is 
oopsing and crashing with recent kernels so this might be a problem of cdfs, 
not the kernel itself.

> And a happy new year!
thanks, dito :)

ciao, Marc
