Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbTBIS1v>; Sun, 9 Feb 2003 13:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTBIS1v>; Sun, 9 Feb 2003 13:27:51 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:38048 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S267417AbTBIS1u>;
	Sun, 9 Feb 2003 13:27:50 -0500
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
From: Kenneth Johansson <ken@kenjo.org>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030206100232.GA9613@axis.demon.co.uk>
References: <20030205174021.GE19678@dualathlon.random>
	 <20030205102308.68899bc3.akpm@digeo.com>
	 <20030205184535.GG19678@dualathlon.random>
	 <20030205114353.6591f4c8.akpm@digeo.com>
	 <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
	 <20030205233115.GB14131@work.bitmover.com>
	 <20030206100232.GA9613@axis.demon.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1044815839.1060.5.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Feb 2003 19:37:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 11:02, Nick Craig-Wood wrote:
> On Wed, Feb 05, 2003 at 03:31:15PM -0800, Larry McVoy wrote:
> > We can go buy another machine for glibc2.3
> 
> Buy a machine?  Why not use UML?

For something as simple as this you do not need anything more than
chroot so one box should do for all linux(glibc) versions. 

But something more like vmware is needed if you also want to have window
and all the other X86 OS on the same box at the same time.



