Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288089AbSACAkS>; Wed, 2 Jan 2002 19:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288084AbSACAim>; Wed, 2 Jan 2002 19:38:42 -0500
Received: from marine.sonic.net ([208.201.224.37]:12073 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S288065AbSACAhy>;
	Wed, 2 Jan 2002 19:37:54 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 16:37:49 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103003748.GB28621@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102235600.GA28621@thune.mrc-home.com> <Pine.LNX.4.33.0201030059130.5131-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201030059130.5131-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 01:00:23AM +0100, Dave Jones wrote:
> And as I've already pointed out twice it isn't a bullet proof solution to
> use DMI anyway in this circumstance.

I never got the impression that DMI was going to be the exclusive way of
obtaining information, but rather, as a supplement.  For example, currently
loaded and functioning drivers may also be analyzed in a variety of ways.

I seem to remember this being described as a goal for CML2 back when ESR
first started talking about it, but I can't find appropriate posts anywhere
(kinda vague thing to look for :-).  And this kind of stuff was discussed
than as well.  Either that or I'm completely mis-remembering.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
