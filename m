Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTBYPD2>; Tue, 25 Feb 2003 10:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267952AbTBYPD2>; Tue, 25 Feb 2003 10:03:28 -0500
Received: from poup.poupinou.org ([195.101.94.96]:799 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267955AbTBYPD1>;
	Tue, 25 Feb 2003 10:03:27 -0500
Date: Tue, 25 Feb 2003 16:13:41 +0100
To: Robert <robert.woerle@symplon.com>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030225151341.GI13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5B835E.7050601@symplon.com>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 03:53:18PM +0100, Robert wrote:
> 
> 
> Ducrot Bruno schrieb:
> 
> >On Mon, Feb 24, 2003 at 07:39:55PM +0100, Pavel Machek wrote:
> > 
> >
> >>Hi!
> >>
> >>   
> >>
> >>>>I have PaceBlade here, and its memory map is wrong, which leads to
> >>>>ACPI refusing to load. [It does not mention "ACPI data" in the memory
> >>>>map at all!]
> >>>>       
> >>>>
> >>>I have made those patches to workaround that.  I have no time
> >>>     
> >>>
> >>Yes, I have seen those... I also made a patch that enables you to do
> >>that workaround from mem= options at kernel command line.
> >>
> >>   
> >>
> >
> >I doubt you received the latest one, since I have not make it public
> >unless this day.
> > 
> >
> i did sent it to him since he recieved our machine from Suse Nuernberg
> 

Ah, OK.  Wasn't aware of that.  But why then making a mem= opitons in
that case.  I have take care to *not* use any mem= at all because that
can make things worse.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
