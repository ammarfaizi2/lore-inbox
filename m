Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSG3WlG>; Tue, 30 Jul 2002 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSG3WlG>; Tue, 30 Jul 2002 18:41:06 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:65238 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S316770AbSG3WlF>;
	Tue, 30 Jul 2002 18:41:05 -0400
Date: Tue, 30 Jul 2002 17:38:37 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.27: JFS oops
In-Reply-To: <200207300738.50302.shaggy@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0207301735360.22313-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Dave Kleikamp wrote:

> 2.5.29 had a problem that is fixed in Linus's bk tree.  I had posted a 
> patch to this list as well.  (Simply remove the calls to d_delete from 
> namei.c.)
> 
> Axel is seeing traps that I haven't seen elsewhere, so that's another 
> potential problem.  We don't know the cause of that one yet.


I've added jfs oops to my problem report status page.  I hope it will be 
clear from the context which one is being discusssed.

