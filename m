Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVELFsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVELFsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVELFsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:48:10 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:744 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261176AbVELFsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:48:06 -0400
Date: Thu, 12 May 2005 07:48:23 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "David S. Miller" <davem@davemloft.net>
cc: 7eggert@gmx.de, nickpiggin@yahoo.com.au, juhl-lkml@dif.dk, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: trailing whitespace fix (was: [PATCH] kernel/module.c has something
 to hide. (whitespace cleanup))
In-Reply-To: <20050511.221919.123971892.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0505120746001.3845@be1.lrz>
References: <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org> <4282D4CA.6030003@yahoo.com.au>
 <Pine.LNX.4.58.0505120644010.3645@be1.lrz> <20050511.221919.123971892.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, David S. Miller wrote:
> From: Bodo Eggert <7eggert@gmx.de>
> > On Thu, 12 May 2005, Nick Piggin wrote:

> > > The patches we want aren't about a
> > > file or a subdirectory or even a subsystem, but they're supposed to be
> > > a logical change. Ie. 1 patch.
> > 
> > That would be too large for most mailboxes. If you like a single patch,
> > you can just concatenate all the patches, so splitting it was a safe bet.
> 
> I'd rather you post a single posting, with URL pointers to
> where people can get the large patches, then sending 430
> patche postings.

These patches fix the trailing whitespace from 2.6.12-rc4:
http://7eggert.dyndns.org/l/patches/trailing-ws/
-- 
Top 100 things you don't want the sysadmin to say:
47. Say, What does "Superblock Error" mean, anyhow?
