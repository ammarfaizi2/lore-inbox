Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264293AbRFMCdN>; Tue, 12 Jun 2001 22:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264295AbRFMCdD>; Tue, 12 Jun 2001 22:33:03 -0400
Received: from utopia.booyaka.com ([206.156.231.220]:63200 "HELO
	utopia.booyaka.com") by vger.kernel.org with SMTP
	id <S264293AbRFMCcu>; Tue, 12 Jun 2001 22:32:50 -0400
Date: Tue, 12 Jun 2001 21:32:48 -0500 (CDT)
From: Paul Walmsley <shag-linux-kernel@booyaka.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hard lockup debugging suggestions?  APIC enabling suggestions?
In-Reply-To: <E154ssA-000550-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106122128130.30220-100000@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Alan Cox wrote:

> > hard several times per day under Linux 2.4.4-ac11.  This lockup occurs
> > during standard use of the system, e.g., web browsing or text editing.
> > (What's particularly strange about the lockup is that sometimes the system
> > will turn off the LCD backlight when it freezes -- but not the LCD panel
> > itself.  Other times, it freezes with the backlight on.)
>
> First things to try: Can you make it die without X, can you make it die if
> you compile without APM or ACPI support.

Further exhaustive testing along the lines you describe above has led me
to believe this is an intermittent hardware problem on the notebook's
motherboard.  I'm able to trigger the hard lockup both in Linux and in
Windows 2000.  It appears to be triggered by stress on a certain part of
the notebook's case.

I'm having the motherboard replaced.  If it turns out not to be the
problem, I'll follow up here.

Thanks for the help,


- Paul

