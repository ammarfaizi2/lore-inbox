Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268651AbTBYUi7>; Tue, 25 Feb 2003 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268652AbTBYUi6>; Tue, 25 Feb 2003 15:38:58 -0500
Received: from poup.poupinou.org ([195.101.94.96]:11297 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S268651AbTBYUi5>; Tue, 25 Feb 2003 15:38:57 -0500
Date: Tue, 25 Feb 2003 21:49:11 +0100
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Pavel Machek <pavel@suse.cz>, Robert <robert.woerle@symplon.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030225204911.GK13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com> <20030225151341.GI13404@poup.poupinou.org> <20030225174449.GD12028@atrey.karlin.mff.cuni.cz> <20030225200907.GJ13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225200907.GJ13404@poup.poupinou.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:09:07PM +0100, Ducrot Bruno wrote:
> Hi Pavel,
> 
> On Tue, Feb 25, 2003 at 06:44:49PM +0100, Pavel Machek wrote:
> > 
> > I've received it after I made my patch, and I think that more machine
> > with broken tables will be created in future...
> > 
> 
> That it not the answer I expected.  To be more clear: you report errors
> on _STA and _INI.  I don't know why.  But with my previous patch, it seems
> that there is no such errors (but it is with 2.4).
> And one of the suspect(s) for what I know is your mem= option patch.

Ok.  Found your patch in LKML.  Soon like to be OK.  Will see then what
hapens, but I need your dmesg.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
