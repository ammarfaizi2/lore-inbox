Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDMTgo>; Fri, 13 Apr 2001 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDMTge>; Fri, 13 Apr 2001 15:36:34 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:50324 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131590AbRDMTgS>;
	Fri, 13 Apr 2001 15:36:18 -0400
Message-Id: <m14o9LX-000Od4C@amadeus.home.nl>
Date: Fri, 13 Apr 2001 20:35:07 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: P.Flinders@ftel.co.uk (Paul Flinders)
Subject: Re: Help with Fasttrack/100 Raid on Linux
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.10.10104122052210.4564-100000@master.linux-ide.org> <3AD6B422.EEC092F0@ftel.co.uk>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AD6B422.EEC092F0@ftel.co.uk> you wrote:
> Andre Hedrick wrote:

> However as far as I can see everyone who has a FastTrak which is "stuck"
> in RAID mode[1] would be happy if it worked as a normal IDE controller
> in Linux, which is (usually?) not the case - eg on the MSI board where
> only the first channel is seen.

I have a patch to work around that. However the better solution would be to
have a native driver for the raid; I plan to start working on that next
week...

Greetings,
  Arjan van de Ven
