Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310256AbSCKRKE>; Mon, 11 Mar 2002 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310261AbSCKRJw>; Mon, 11 Mar 2002 12:09:52 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:21774 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S310256AbSCKRJr>; Mon, 11 Mar 2002 12:09:47 -0500
Date: Mon, 11 Mar 2002 11:10:19 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020311111019.F25601@twoflower.internal.do>
In-Reply-To: <E16kT8L-00014f-00@the-village.bc.nu> <3C8CE34B.4030800@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8CE34B.4030800@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Mar 11, 2002 at 06:03:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> For your information: I have read the standard papers and comments
> to them. But the application notes from IBM and actual code
> from different operating systems gives a much better formal
> description of what is needed anyway. Or are you going to claim
> that narrative languaue is more precise then actual C code?

It appears that you're confusing an implementation of a specification with the
specification itself.  The specification wins out, and therefore you can't
just copy the behvaiour of another implementation.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
