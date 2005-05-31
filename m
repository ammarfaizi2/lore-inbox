Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVEaQZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVEaQZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVEaQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:19:06 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:21697 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261941AbVEaQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:12:16 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Roy Keene <rkeene@psislidell.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
Date: Tue, 31 May 2005 16:12:13 +0000
Message-Id: <053120051612.19940.429C8CDD000A6E5800004DE4220073407600009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Info: Linux cog1 2.6.9-5.0.5.ELsmp #1 SMP Fri Apr 8 14:29:47 EDT 2005 i686 i686 
> i386 GNU/Linux
> Dist: RedHat Enterprise Linux 4
> Spec:
>      2 x 3.2GHz Xeon (each system, with hyperthreading so 4 logical processors)
>      4GB of physical RAM
>      2GB of configured swap (partition, contigious)
>      2 x 1000Mbps (Intel 82546GB) network cards (HA cluster link is
>                provided by a cross over cable between the two nodes)
> -

Since you are using a vendor kernel which is older than the current 2.6 kernel.org one - you are better off posting to appropriate vendor mailing  list or ask them for support if you have a contract. Or else, try to reproduce the problem with latest kernel.org kernel and then re-post the information here.

Parag


