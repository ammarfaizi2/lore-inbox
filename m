Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbSK2DnU>; Thu, 28 Nov 2002 22:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbSK2DnU>; Thu, 28 Nov 2002 22:43:20 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1540 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S266953AbSK2DnT>;
	Thu, 28 Nov 2002 22:43:19 -0500
Date: Thu, 28 Nov 2002 21:41:40 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Keith Owens <kaos@ocs.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [RELEASE] module-init-tools 0.8 
In-Reply-To: <5127.1038538229@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0211282112040.895-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Keith Owens wrote:

> On Thu, 28 Nov 2002 20:24:33 -0600 (CST), 
> Thomas Molina <tmolina@copper.net> wrote:
> >I want to get 2.5 working, but module loading doesn't work and 
> >modutils-2.4.21-4.i386.rpm and 
> >modutils-2.4.21-5.i386.rpm break 2.4 kernels.
> 
> Whose version of modutils are you complaining about?  My base versions
> of modutils 2.4.21 and 2.4.22 work fine for me on 2.4 kernels.

Keith, 

I am currently using your modutils-2.4.22-1.i386.rpm which work fine 
with 2.4 kernels.  The ones I said were borked were in Rusty's directory 
at ftp.kernel.org/pub/linux/kernel/people/rusty/modules.  I was using his 
versions since I was testing some of his patches.

