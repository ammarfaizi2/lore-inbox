Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRAZWAK>; Fri, 26 Jan 2001 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRAZWAA>; Fri, 26 Jan 2001 17:00:00 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:4370 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S130329AbRAZV7o>; Fri, 26 Jan 2001 16:59:44 -0500
Date: Fri, 26 Jan 2001 16:59:13 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: sl@fireplug.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126165913.D1432@alcove.wittsend.com>
Mail-Followup-To: sl@fireplug.net, linux-kernel@vger.kernel.org
In-Reply-To: <980523239.30846@whiskey.enposte.net> <94sriq$4b7$1@whiskey.enposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <94sriq$4b7$1@whiskey.enposte.net>; from sl@whiskey.fireplug.net on Fri, Jan 26, 2001 at 01:52:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 01:52:26PM -0800, Stuart Lynne wrote:
> In article <980523239.30846@whiskey.enposte.net>,
> James Sutherland <jas88@cam.ac.uk> wrote:
> >On Fri, 26 Jan 2001, Lars Marowsky-Bree wrote:

> >Except you can't retry without ECN, because DaveM wants to do a Microsoft
> >and force ECN on everyone, whether they like it or not. If ECN is so

> No, he just wants them to ignore it like they are supposed to do if
> they don't know what it is.

> >wonderful, why doesn't anybody actually WANT to use it anyway?

> Because they are stupid and don't want to take the time and energy
> to upgrade their systems. 

> Most ISP's have the generic rule, if it ain't broke, don't fuck with it.
> Even the mighty microsoft learned just two days ago what happens if you
> make mistakes changing routing information.

	No...  Microsoft learned, just two days ago, something that has
been part of best practices for over 15 years.  Do NOT put all of your
DNS servers on the same network!  The technical error may have triggered
the meltdown but if they had distributed their DNS the way they were
suppose to, it would have NOT taken them totally out.  It wasn't the
technician's mistake.  It was the single point of failure (and subsequently
the single point of attack).  He just triggered it.

> -- 
>                                             __O 
> Lineo - For Emedded Linux Solutions       _-\<,_ 
> PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
> Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
