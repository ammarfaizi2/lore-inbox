Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137210AbREKS6I>; Fri, 11 May 2001 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137212AbREKS56>; Fri, 11 May 2001 14:57:58 -0400
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:20232 "EHLO
	ace.ulyssis.org") by vger.kernel.org with ESMTP id <S137210AbREKS5s>;
	Fri, 11 May 2001 14:57:48 -0400
Date: Fri, 11 May 2001 20:57:40 +0200 (CEST)
From: Chipzz <chipzz@ULYSSIS.Org>
X-X-Sender: <chipzz@ace>
Reply-To: <Chipzz@ULYSSIS.Org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 - Locked keyboard
In-Reply-To: <E14yHCN-0000kW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105112055080.15097-100000@ace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Alan Cox wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: 2.4.2 - Locked keyboard
>
> >     I changed the keyboard and looked at the keyboard plugs unsucessful=
> > ly.
> >
> >     Could this be related to a kernel bug or an userspace issue??? How =
> > can I
> > debug it?
>
> I think its kernel related. There are a few other reports of 'my computer
> is fine but they keyboard stopped working' with 2.4.x. Does the box have
> a ps/2 mouse ?

I have the same problem (keyboard stops working) on 2.2 too. Keyboard is
serial (or what's the non-ps/2 thing called?), mouse is ps/2, happens when I
switch consoles. (in most cases X vs text, but not always, happened to me
once right after reboot too, when switching between 2 text consoles).

I can still ssh into the box and reboot it thou

Greetings,

Chipzz AKA
Jan Van Buggenhout
-- 

--------------------------------------------------------------------------
                  UNIX isn't dead - It just smells funny
                            Chipzz@ULYSSIS.Org
--------------------------------------------------------------------------

