Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRASOyE>; Fri, 19 Jan 2001 09:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbRASOxy>; Fri, 19 Jan 2001 09:53:54 -0500
Received: from styx.suse.cz ([195.70.145.226]:5359 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130762AbRASOxn>;
	Fri, 19 Jan 2001 09:53:43 -0500
Date: Fri, 19 Jan 2001 15:53:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Howard Johnson <merlin@blacklight.gweep.org.uk>
Cc: "John O'Donnell" <johnod@voicefx.com>,
        Matthew Fredrickson <lists@frednet.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010119155333.A2050@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org> <3A677D17.8000701@voicefx.com> <20010118234225.A7210@www.mwob.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010118234225.A7210@www.mwob.org.uk>; from merlin@blacklight.gweep.org.uk on Thu, Jan 18, 2001 at 11:42:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 11:42:25PM +0000, Howard Johnson wrote:
> On Thu, Jan 18, 2001 at 06:32:39PM -0500, John O'Donnell wrote:
> > Matthew Fredrickson wrote:
> > 
> > I have the ASUS CUV4X.
> > VIA vt82c686a (cf/cg) IDE UDMA66 controller on pci0:4.1
> > I also run DMA66 with no problems here.
> > 
> > I never have seen any issues with the PS/2 mouse and X.
> > I use the Logitech cordless wheel mouse.  I use the "MouseManPlusPS/2"
> > driver in XFree.  When I was first setting this up (about a year ago)
> > I had the problems you mention.  I read an article on setting up your
> > scroll wheel in X and it said to use the IMPS/2 setting.  This was
> > nothing but trouble, till I RTFM on XFree and mice and found my solution.
> > Can you tell us what kind of mouse this is and how you have it set up in
> > XFree.
> > 
> > Let's take this mouse discussion off list as it has nuttin to do with
> > the kernel....
> > Johnny O
> 
> I'm seeing the same mouse problems... fine under 2.2.x, but jumps around under
> a couple of 2.4.x releases (2.4.0-test6, IIRC, and 2.4.1-pre7). I find it odd
> that if it isn't a kernel-related problem, that it's only manifesting itself
> under 2.4.
> 
> I'm running a slot A athlon on an abit KA7-100.

My bet is ACPI/powermanagement messing with it ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
