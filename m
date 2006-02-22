Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWBVHG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWBVHG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBVHG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:06:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41092 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932074AbWBVHG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:06:26 -0500
Date: Wed, 22 Feb 2006 09:06:10 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Kay Sievers <kay.sievers@suse.de>
cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060221225718.GA12480@vrfy.org>
Message-ID: <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de>
 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
 <20060221225718.GA12480@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Kay Sievers wrote:
> > 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> > diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> > Author: Kay Sievers <kay.sievers@suse.de>
> > Date:   Fri Nov 11 06:09:55 2005 +0100
> > 
> >     [PATCH] remove mount/umount uevents from superblock handling

On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> Upgrade HAL, it's too old for that kernel.

It's what Gentoo stable is carrying. Thou shalt not break userspace!

			Pekka
