Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318193AbSG3AgX>; Mon, 29 Jul 2002 20:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSG3AgX>; Mon, 29 Jul 2002 20:36:23 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:9685 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318193AbSG3AgX>;
	Mon, 29 Jul 2002 20:36:23 -0400
Date: Mon, 29 Jul 2002 19:33:54 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.27: JFS oops
In-Reply-To: <200207291643.14602.shaggy@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0207291927160.19349-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Dave Kleikamp wrote:

> On Monday 29 July 2002 10:06, Axel Siebenwirth wrote:
> > Hi Dave,
> >
> > here goes another jfsCommit oops from kernel 2.5.27.
> 
> I haven't seen this trap before.  I'll take a closer look at it, and let 
> you know what I find.
> 
> > Can I use jfs from cvs with current kernels (2.5.29/2.4.19-rc3-ac3)
> > to see how latest changes work?
> 
> Yes.  You should be able to just replace everything under fs/jfs with 
> what's in cvs.

Are you saying jfs in 2.5.29 jfs is not a problem?  I'm looking to see if 
I should put it on my problem status report.

