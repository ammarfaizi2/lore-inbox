Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTJaRkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 12:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJaRkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 12:40:19 -0500
Received: from devil.servak.biz ([209.124.81.2]:43476 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S263435AbTJaRkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 12:40:16 -0500
Subject: Re: WD Raptor/SATA with RAID0 way to slow
From: Torrey Hoffman <thoffman@arnor.net>
To: Julien Oster <lkml@mc.frodoid.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <frodoid.frodo.873cdadsux.fsf@usenet.frodoid.org>
References: <frodoid.frodo.873cdadsux.fsf@usenet.frodoid.org>
Content-Type: text/plain
Message-Id: <1067621682.1119.115.camel@rivendell.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 31 Oct 2003 09:34:42 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 18:49, Julien Oster wrote:
> Hello,
> 
> I recently purchased an Asus A7N8X mainboard with the Silicon Imaging
> SATA controller online and two Western Digital Raptor SATA harddrives
> with 10krpm.
> 
> Those harddisks are supposed to be "really fast", but I don't really
> get the performance out of them. In fact, I get much less performance
> than with my "standard consumer" IBM DeskStars.

What version of the Linux kernel are you using?  What does the kernel
log say about how it is detecting and configuring your drives?


-- 
Torrey Hoffman <thoffman@arnor.net>

