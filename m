Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTETREQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTETREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:04:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16001 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263568AbTETREP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:04:15 -0400
Date: Tue, 20 May 2003 13:19:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: Gerald Stuhrberg <grstuhrberg@aaahawk.com>, linux-kernel@vger.kernel.org
Subject: Re: DHCP
In-Reply-To: <1053449334.7780.25.camel@serpentine.internal.keyresearch.com>
Message-ID: <Pine.LNX.4.53.0305201312270.5930@chaos>
References: <200305191821.h4JILlE12026@adam.yggdrasil.com> 
 <1053398767.22400.8.camel@localhost> <1053449334.7780.25.camel@serpentine.internal.keyresearch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Bryan O'Sullivan wrote:

> On Mon, 2003-05-19 at 19:46, Gerald Stuhrberg wrote:
> > I was just wondering if anyone had plans to implement a DHCP client in
> > the kernel.
>
> There's already one there.  The plan is to rip it out.
>
> 	<b

Isn't it that there are 'helper' functions in the kernel that are
not needed and a user-space DHCP server already works and is
available? Read LinuxPlanet(tm). There may be a DHCP server
in many/most distributions.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

