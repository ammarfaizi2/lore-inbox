Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUHOWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUHOWZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUHOWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:25:33 -0400
Received: from foxxy.triohost.com ([65.110.50.10]:63192 "EHLO
	foxxy.triohost.com") by vger.kernel.org with ESMTP id S267186AbUHOWZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:25:31 -0400
Date: Sun, 15 Aug 2004 18:25:17 -0400 (EDT)
From: Sindi Keesan <keesan@iamjlamb.com>
X-X-Sender: keesan@foxxy.triohost.com
To: Martin Mares <mj@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: mdacon and scroll buffer
In-Reply-To: <20040815170228.GA25095@ucw.cz>
Message-ID: <Pine.LNX.4.44.0408151819040.28148-100000@foxxy.triohost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Martin Mares wrote:

> Hello!
> 
> > Mdacon appears to have no Scroll_Backward or _Forward feature (scroll
> > buffer) like vgacon does (shift Page Up or shift Page Down).  I use
> > mdacon.o with a 2-monitor system.  Is there something in vgacon.c I could
> > copy over to mdacon.c so I could try to compile my own version with scroll
> > buffer?
> 
> On which card do you run mdacon?  Hercules or something MDA-like?

Some sort of generic.  I have others that I could try, including a winbond 
W8685AF (I have marked it on the back 3BCh for some reason - maybe a 
nonstandard address, original price $21.78, made in China) and a Korean 
/Malaysian model with more chips .  Both have jumpers:  in one case
JP1 JP2 and in the other a 3-pin J4.

I have the lack of scroll in two computers with cards that I cannot easily 
look at.

These are all 16-bit half-length cards (length about the width of my hand) 
with parport build-in (which does not print in linux - another problem 
with using two video cards). 

This is certainly a busy mail list!

> > 				Have a 
nice fortnight > 

