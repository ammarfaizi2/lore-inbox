Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268461AbRG3KQU>; Mon, 30 Jul 2001 06:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268457AbRG3KQK>; Mon, 30 Jul 2001 06:16:10 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:4612 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S268468AbRG3KP7>; Mon, 30 Jul 2001 06:15:59 -0400
Date: Mon, 30 Jul 2001 12:17:22 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Steffen Persvold <sp@scali.no>
Cc: Gav <gavbaker@ntlworld.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <3B65099E.8004F9E5@scali.no>
Message-ID: <Pine.LNX.4.33.0107301213440.15803-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Hmm, I think "DRAM Prefetch" is the one you _don't_ want to turn on, because (and correct
> me if i'm wrong) it's causing all the problems with the IDE controller (data trashing).

I think it was IDE Prefetch that should be off (I had this problem on a
AMD 486DX4-133 with Award Bios, turning it on trashed the boot record in
minutes (and many other sectors on the disk too).

Anyone here care to give a link to that program to enable DRAM Prefetch?
My sister has a Duron 750w with VIA motherboard and music and sound pop on
any graphics changes, maybe this is it?

Regards,

Maciej Zenczykowski

