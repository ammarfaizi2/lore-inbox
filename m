Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268453AbRHBRyV>; Thu, 2 Aug 2001 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbRHBRyL>; Thu, 2 Aug 2001 13:54:11 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:26637 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S268453AbRHBRxv>;
	Thu, 2 Aug 2001 13:53:51 -0400
Date: Thu, 2 Aug 2001 12:07:34 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE_CS in 2.4.7
In-Reply-To: <E15SJJD-0000eB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10108021205010.393-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alan Cox wrote:

> > When I insert the card, I get a beep from the cardmgr program seeing the
> > card being inserted.  Then the whole system refuses to respond to anything
> > on the keyboard.  (I have not tested if the system is reachable by network
> > when that happens.) 
> 
> Gunther posted this patch ages ago which seems to solve the problem

I will try that. Any reason it did not make it to 2.4.7?

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

