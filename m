Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271690AbTHDJjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271700AbTHDJjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:39:23 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:31213 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S271690AbTHDJjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:39:21 -0400
Date: Mon, 4 Aug 2003 11:37:57 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: bert hubert <ahu@ds9a.nl>
cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from
 being modified easily
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0308041122090.533-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After being gloriously rootkitted with a program coded by HTB author Martin
> Devera (lots of thanks, devik, your work is appreciated, I suggest you read
> up about Oppenheimer when disclaiming that you are 'just a coder'. The item
> to google on is: "ethics sweetness hydrogen bomb Oppenheimer"), I wrote

Hi,

I feel I should react to this publicaly - however all replies should
be send to me privately as it is off-topic.
SucKIT is NOT written by me - I have no time to do such things. One
time I've been rootkited by older suckit. I was able to track the attacker
down (because he drunk much beer before doing the attack).
I started to chat with him because I wanted to know more about security
especially to be able to safe my servers.
Disabling /dev/{,k}mem was part of it. At this time he asked me what I
think about possibility to change syscall table with no previous
knowledge. I replied with test code which is able to locate syscall table
and kmalloc routine address using some statistics on /dev/kmem.
We made article for Phrack magazine which discovered the posibility
and how to defend itself. It was end of the story for me.
Later I find that some other crackers are using/distribute better
SucKIT and that my name is often displayed on start of rootkited system.

I want to say that I'm not affiliated with SucKIT nor with cracking
and rootkiting of servers. I'll try to convince mentioned hacker
to remove my name from the kit as I'm tired of all the complaints :-(

If you feel that I'm source of your problems then I'm sorry for it.

devik


