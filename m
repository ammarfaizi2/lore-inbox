Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSGNNqS>; Sun, 14 Jul 2002 09:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSGNNqR>; Sun, 14 Jul 2002 09:46:17 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:14470 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315260AbSGNNqQ>; Sun, 14 Jul 2002 09:46:16 -0400
Date: Sun, 14 Jul 2002 15:47:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141347.g6EDlU9k019093@burner.fokus.gmd.de>
To: andre@linux-ide.org, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Andre Hedrick <andre@linux-ide.org>

First: Top posting is something that disqualifies you. Please don't 
top post otherwise people will belive that you are just a troll.

>Don't take this personally but you are just a top level application.
>The only reason you have such blinders on is because you always had a
>bottom layer transport working around and doing its best to prevent
>errors form showing up.  You are wrong and because you are not down on the
>bus at the physical layer you do see the mess.

I don't take this personal, but the main problem seems to be that most
of the people in this discussion have far less kernel experience than I have.
I did actively write code from many different places in different OS 
implementaions. Ans more important, I did read a lot of other people's code.
If Linux people have kernel experience at all, they usually only know
a specific part of one single OS: Linux.

Writing good kernel code is more! It educates a lot to read read read
a lot in other OS sources to understand other ideas and to become
able to judge about the quality os a specific implementation.

You seem to have no experience than IDE in Linux. It would help if you 
first look at other implementations in order to become able to judge yourself.

>Now your silly PCATA stupid ass Tailgate Bridge that you are boasting
>about does some of the worst things anyone could ever imagine.

???? Looks stupid (like dou did not get the message).

>Oh and the bad idea you call is to permit dynamic subdriver shifting.
>Now that it may never be completed you have the advantage to call it a bad
>idea.  I suspect you are an ASPI lover and soone SPI will die.

Please read what I wrote and don't guess what I might have written.

>Next your statements about name a drive is a straw man.
>More basic proof you do not look down at the hardware.

???? Looks completely unrelated to the thread and to my mail.

>BurnProof is a result lame devices which improperly hold off the bus
>because release the BUSY Bit while still performing transfers.
>The very fact that a huge pile of devices went into the market place
>based on SFF-8020 rev 2.5 total roasts your strawman, please try again.

Again: this is completely unrelated to the problem. Why do you introduce
it?


>So instead of whining about what is there and not from your location in
>end user land, try and offer something useful like a preferred API to
>allow clean packet-driver interfaces.  Doing that little would allow the
>transport layer people and the transistion-api folks to user land to
>greatly increase compatablity.  Then you would not need 5 interfaces for
>Linux.

>Have a good day.

I am not whining, but you answer with  unrelated stuff. Why? Are you missing
experience and arguments?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
