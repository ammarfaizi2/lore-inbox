Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267941AbTBYOYx>; Tue, 25 Feb 2003 09:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTBYOYx>; Tue, 25 Feb 2003 09:24:53 -0500
Received: from poup.poupinou.org ([195.101.94.96]:48926 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267941AbTBYOYw>; Tue, 25 Feb 2003 09:24:52 -0500
Date: Tue, 25 Feb 2003 15:35:05 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030225143505.GH13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224183955.GC517@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 07:39:55PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I have PaceBlade here, and its memory map is wrong, which leads to
> > > ACPI refusing to load. [It does not mention "ACPI data" in the memory
> > > map at all!]
> > 
> > I have made those patches to workaround that.  I have no time
> 
> Yes, I have seen those... I also made a patch that enables you to do
> that workaround from mem= options at kernel command line.
> 

I doubt you received the latest one, since I have not make it public
unless this day.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
