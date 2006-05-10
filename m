Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWEJUxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWEJUxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWEJUxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:53:37 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7095 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964815AbWEJUxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:53:36 -0400
Date: Wed, 10 May 2006 16:53:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Adrian Bunk <bunk@stusta.de>
cc: Stephen Hemminger <shemminger@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <20060510203622.GT3570@stusta.de>
Message-ID: <Pine.LNX.4.58.0605101645581.22959@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
 <1147257266.17886.3.camel@localhost.localdomain>
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de>
 <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com> <20060510202401.GS3570@stusta.de>
 <20060510203622.GT3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Adrian Bunk wrote:

>
> Same with gcc 4.0.

I had a typo. it's 4.0.4

gcc version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2)

But it is a Debian "prerelease".

>
> I can reproduce your problem only with gcc 3.3 and gcc 3.4.
>
> Can we please discuss issues in current gcc releases instead of gcc
> bashing ("Oh fsck! gcc is hosed.") based on issues no longer present in
> the latest two major releases of gcc?
>

Apologies to gcc.  It's no excuse, but I get a bit ansie when I'm late a
work debugging lots of problems.  Both work related and LKML related.
I think I took my frustrations out in that email.

So I don't unneccessarily insult anyone else, I'm calling it a day.

-- Steve

