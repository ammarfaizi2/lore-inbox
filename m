Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262942AbTC3BJz>; Sat, 29 Mar 2003 20:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTC3BJz>; Sat, 29 Mar 2003 20:09:55 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:50618 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262942AbTC3BJy>; Sat, 29 Mar 2003 20:09:54 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Robert Love <rml@tech9.net>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048980204.13757.17.camel@localhost>
References: <3E8610EA.8080309@telia.com>
	 <1048980204.13757.17.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1048987260.679.7.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 30 Mar 2003 03:21:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 00:23, Robert Love wrote:
> This seems to confirm it was one of the interactivity changes that went
> into 2.5.65.  I figured as much but it is nice to get confirmation. 
> Thank you for trying this.
> 
> Now to figure out which one...
> 
> > My system is a P-III 700 (Inspiron 4000),
> > and Debian (X is running at nice = -10).
> 
> I wonder if the reniced X is a factor?

Theoretically, with interactivity enhancaments, you'll never need to
renice X. In fact, I'm running X with no renice and it feels pretty
snappy.

> 
> ______________________________________________________________________
>        Felipe Alfaro Solana
>    Linux Registered User #287198
> http://counter.li.org

