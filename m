Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291889AbSBNUzd>; Thu, 14 Feb 2002 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBNUxQ>; Thu, 14 Feb 2002 15:53:16 -0500
Received: from mark.staudinger.net ([207.252.75.224]:24583 "EHLO
	mark.staudinger.net") by vger.kernel.org with ESMTP
	id <S291903AbSBNUwO>; Thu, 14 Feb 2002 15:52:14 -0500
Message-Id: <200202142104.g1EL4QoX036335@mark.staudinger.net>
Date: Thu, 14 Feb 2002 21:04:26 -0000
To: "John Alvord" <jalvo@mbay.net>
Subject: Re: 2.4.12 on Pentium?
From: "Mark Staudinger" <mark@staudinger.net>
X-Mailer: TWIG 2.6.2
In-Reply-To: <nl5o6u0dfp19th6om3pncipcoigj9dsco1@4ax.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: mark@staudinger.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord <jalvo@mbay.net> said:

> One common failure reason is selecting the wrong processor type. I
> suggest starting with a plain vanilla i386 build and see what happens.
> 
> john

That's the first thing I looked at... and my original message references 
that.  I've tried Pentium Classic, MMX, and 386.  No such luck.

Thanks....

> 
> On Thu, 14 Feb 2002 19:55:58 -0000, "Mark Staudinger"
> <mark@staudinger.net> wrote:
> 
> >"Drew P. Vogel" <dvogel@intercarve.net> said:
> >
> >> On Thu, 14 Feb 2002, Mark Staudinger wrote:
> >> 
> >> >
> >> >Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU? 
 
> >I'm
> >> >unable to get a 2.4.12 kernel to boot on a pentium class machine, 
> >regardless
> >> >of what I choose for the "Processor Family" support in the config.
> >> >
> >> >A similar (if not identical) config of kernel 2.4.5 works just fine, 
even 
> >if
> >> >compiled for 686/Celeron processor family.
> >> 
> >> copy the .config from the 2.4.5 directory and do a 'make oldconfig' just
> >> to be sure.
> >> 
> >> --Drew Vogel
> >
> >Done.  Still the same symptom (reset during kernel load). I take it this 
isn't 
> >a known problem then?
> >
> >-=Mark
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 



