Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTA1L7J>; Tue, 28 Jan 2003 06:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTA1L7J>; Tue, 28 Jan 2003 06:59:09 -0500
Received: from [195.72.113.150] ([195.72.113.150]:58120 "EHLO
	schubert.rdns.com") by vger.kernel.org with ESMTP
	id <S264984AbTA1L7I>; Tue, 28 Jan 2003 06:59:08 -0500
Date: Tue, 28 Jan 2003 12:08:26 +0000 (GMT)
From: Robert Morris <rob@r-morris.co.uk>
X-X-Sender: rob@schubert.rdns.com
To: John Bradford <john@grabjohn.com>
cc: Raphael_Schmid@CUBUS.COM, <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <200301281144.h0SBi0ld000233@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0301281149070.20509-100000@schubert.rdns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

On Tue, 28 Jan 2003, John Bradford wrote:

> > There is a very simple reason why Linux shouldn't have a "bootscreen" - 
> > its a lame idea.
> 
> For a desktop or server machine, yes.
> 
> There are applications where it is not appropriate to have it, though,
> what if you were using Linux in an embedded device such as a set top
> box?

I agree that it may be less inappropriate for certain specialised 
applications, such as the one you suggested, but Raphael made specific 
reference to Windows and Mac OS, which implies desktop use.

I am totally fed up with the quest to make Linux into as close to a copy 
of Windows as possible.


> It's perfectly possible that somebody might want to make a television
> set top box out of a standard x86 motherboard and VGA card, and not
> have anything displayed until X starts, because the television would
> not accept the standard VGA scanrate, but X can easily re-program that
> to around 15 Khz.

OK, but in this case you would have problems with BIOS output etc. If you 
left Linux alone, but fixed the BIOS to output at the required 
frequencies, it would work - and using the quiet option, together with 
appropriate output from the init scripts (which would presuambly be 
heavily customised, in such an application) would yield a similar result.

And I question the approach of automatically deciding to hide startup
output from the user, in any case. I can imagine a set-top box user on the
phone to the support department saying "it gets to the Starting - Please
Wait screen, then just hangs", which would then require an engineer visit,
as opposed to, for example, "it says Obtaining IP Address... then hangs"  
which would give the support techie the opportunity to tell the user to
check the ethernet cable is plugged in correctly, etc, before resorting to
sending out an engineer.


Robert Morris
08707 458710
http://www.r-morris.co.uk/

