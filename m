Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbSJJSaw>; Thu, 10 Oct 2002 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJJSaG>; Thu, 10 Oct 2002 14:30:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261936AbSJJS3T>; Thu, 10 Oct 2002 14:29:19 -0400
Date: Thu, 10 Oct 2002 11:33:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <johnstul@us.ibm.com>
Subject: Re: [BK PATCH] i386 timer changes for 2.5.41
In-Reply-To: <20021010182652.GA25871@kroah.com>
Message-ID: <Pine.LNX.4.44.0210101132300.4124-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Oct 2002, Greg KH wrote:
> 
> I've taken the i386 timer.c patches that John Stultz has been working on
> for a while

Hmm, I was getting to them anyway, this would make it easier. 

Except for the fact that I get

	[torvalds@penguin linux]$ bk pull bk://lsm.bkbits.net/timer-2.5
	ERROR-cannot cd to timer-2.5 (illegal, nonexistant, or not package root)

when I try to check it out..

		Linus

