Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTDYPtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 11:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTDYPtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 11:49:51 -0400
Received: from collamer.mail.atl.earthlink.net ([199.174.114.9]:15908 "EHLO
	collamer.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S263364AbTDYPtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 11:49:50 -0400
Date: Fri, 25 Apr 2003 10:56:47 -0400
From: Wil Reichert <wilreichert@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac1: Filesystem corruption
Message-Id: <20030425105647.24760c35.wilreichert@yahoo.com>
In-Reply-To: <20030425073652.GA2089@defiant.crash>
References: <20030425073652.GA2089@defiant.crash>
Organization: NA
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've experienced corruption on an ext3 filesystem.
> Motherboard: Asus A7N8A Chipset: NForce2
> 
> Kernel-config is attatched
> 
> Harddrives:
> hda: IBM-DJNA-351520
> hdb: IC35L080AVVA07-0

Maybe your problem is in the kernel, maybe not.  hdb is an IBM 80 Gig?  Be afraid, those drives are notorious for going bad.  Yesterday a similar model randomly ate half a partition then lost its boot sector for a couple hours.  Today I can run a write mode badblocks with no errors to be found.

Hope you make backups.

Wil
