Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbSK3HUY>; Sat, 30 Nov 2002 02:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbSK3HUX>; Sat, 30 Nov 2002 02:20:23 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15369 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267221AbSK3HUX>; Sat, 30 Nov 2002 02:20:23 -0500
Message-Id: <200211300722.gAU7MMp04219@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Max Valdez <maxvaldez@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: swap usage on most 2.4.x kernels
Date: Sat, 30 Nov 2002 10:12:42 -0200
X-Mailer: KMail [version 1.3.2]
References: <1038315477.3403.18.camel@garaged.fis.unam.mx>
In-Reply-To: <1038315477.3403.18.camel@garaged.fis.unam.mx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 November 2002 10:57, Max Valdez wrote:
> Hi all:
>
> I have the same question that most people must have, why I need to
> manually erase swap to avoid excesive paging after a couple of uptime
> days ??.

What?

> Once i have most of my RAM ocupied (more than 50% by cache ona a 1GB
> box) the swaping starts to be a problem,  I know the problem is that
> i like a fancy desktop style, and memory eating programs to read the
> damn email, but I think there should be a way to decrese the swaping
> isnt it ??.. after all, most of the ram is in chache !!, is it really
> that necesary ??

There are some /proc tunables, never used 'em muself...

Care to show us /proc/meminfo, top output etc?
People will be interesting *what* is eating your mem.

> BTW, im starting to have the same "old" pagging problem with
> 2.4.20-rc2-ac3. after 1 uptime day. and it seems to be getting worst,
> could it be a hardware problem ??, maybe my ram chips are passing the
> way ?

What? You want to say they are getting slower or smaller with time? ;)
--
vda
