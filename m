Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTACOqv>; Fri, 3 Jan 2003 09:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTACOqv>; Fri, 3 Jan 2003 09:46:51 -0500
Received: from pdbn-d9bb8758.pool.mediaWays.net ([217.187.135.88]:36622 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S267535AbTACOqs>;
	Fri, 3 Jan 2003 09:46:48 -0500
Date: Fri, 3 Jan 2003 15:55:14 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
Message-ID: <20030103145514.GA5566@citd.de>
References: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 02:25:09PM +0100, Maciej Soltysiak wrote:
> Hi,
> 
> I am in a t-shirt transfering frenzy and was wondering which part of the
> kernel code it would be best to have on my t-shirt.
> I was looking at my favourite: netfilter code, but it is to clean, short
> and simple functions, no tons of pointers, no mallocs, no hex numbers, too
> many defines used. I was looking for something terribly complicated and
> looking awesome to the eye.
> 
> How about we have a poll of the most frightening pieces of the kernel ?
> What are your ideas?

egrep -ir "(on fire)" *

drivers/usb/printer.c:static char *usblp_messages[] = { "ok", "out of paper", "off-line", "on fire" };

:-)



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

