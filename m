Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSBOMiK>; Fri, 15 Feb 2002 07:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSBOMiA>; Fri, 15 Feb 2002 07:38:00 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:48134 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288958AbSBOMhv>; Fri, 15 Feb 2002 07:37:51 -0500
Date: Fri, 15 Feb 2002 13:37:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020215133749.E5096@suse.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com> <20020215132030.A5096@suse.cz> <3C6CFDFF.5080108@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6CFDFF.5080108@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 15, 2002 at 01:24:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 01:24:31PM +0100, Martin Dalecki wrote:

> >On Fri, Feb 15, 2002 at 09:06:52AM +0100, Martin Dalecki wrote:
> >
> my bla bla was here...
> 
> >
> >And these steps also sound very good to me.
> >
> 
> How wired is yours setup and would you engage in testing? I'm in especially
> a bit of in fear to the fact that I don't have access to any ATAPI 
> interface based streamer (the rest I can get around with ;-).

I'll test it, yes, but I also don't have an ATAPI streamer available. I
have CD-ROMs, DVD-ROMs, CD-RW, can test it on an ATAPI ZIP, and that's
about it.

I'm also planning to start cleaning up ide-pci.c, removing most of that
file in the process.

-- 
Vojtech Pavlik
SuSE Labs
