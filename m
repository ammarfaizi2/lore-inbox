Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129592AbRBMLuA>; Tue, 13 Feb 2001 06:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRBMLtl>; Tue, 13 Feb 2001 06:49:41 -0500
Received: from host217-32-132-155.hg.mdip.bt.net ([217.32.132.155]:51973 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129592AbRBMLtK>;
	Tue, 13 Feb 2001 06:49:10 -0500
Date: Tue, 13 Feb 2001 11:45:57 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: lost charaters -- this is becoming annoying!
In-Reply-To: <Pine.LNX.4.21.0102131134300.927-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0102131139430.927-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I decided to write this email inine on the console and... see? the
"inine" was supped to be "in pine" (not to mention the "supped" :)

Yes, I do lose characters when working in pine on the console!

So, it is not X-specific.

Now, what I was going to write this email about was -- I get the same
effect licq (just lost "in" before licq!) so it is not xterm-specific but
probably that is not importt anymore (just lost "an" in
"important").. (lost a . in "..." :)

Tgran (unbelievable -- it doesn't even let me spell my own name
correctly!)

On Tue, 13 Feb 2001, Tigran Aivazian wrote:

> Hi Andrew,
> 
> Keyboard internal, but... you are right -- this _only_ happens when the
> laptop is plugged into the docking station... that could be an extra clue
> (i.e. two PS/2 controllers simultaneously -- maybe the docking station one
> needs to be somehow explicitly disabled).
> 
> How come I can't tell? Because when I type on the console it seems to be
> ok, i.e. it is probably _not_ a keyboard driver. On the other hand, on the
> laptop I don't type that much on the console and spend all the time in
> X in xterm. That is why I am not certain what exactly is broken.
> 
> I do not have ACPI enabled, nor APM in the kernel.
> 
> Regards,
> Tigran
> 
> On Tue, 13 Feb 2001, Andrew Morton wrote:
> 
> > Hi, Tigran.
> > 
> > Internal keyboard, or external?
> > 
> > Does it happen on the console or just in X?  (How come you can't
> > tell whether it's the k/b driver or the PTY driver?)
> > 
> > Tried disabling ACPI?
> > 
> > Tigran Aivazian wrote:
> > > 
> > > Hi,
> > > 
> > > I amtyping this without correcting -- allthe lost characters you see
> > > (including spaces!) are exactly what the pseudo-tty driver does! This is
> > > 2.4.1 a it definitely (oh, see "nd" of the ave "and" disappeared? and
> > > "above" turned into "ave"!) did work fine previously -- like in the days
> > > of 2.3.99 and 2.4.0-teX series (yes, teX was meant to be "testX"!)
> > > 
> > > So, the keyboard or pty driver is badly broken.
> > > 
> > > Regards,
> > > Tigran
> > > 
> > > PS. This only happens on this Dell latitude CPx (notice lost shift in
> > > Latitude?) H450GT.
> > > 
> > > PPS. No, my laptop is fine -- rebootingnto 2.2.x makes it type without
> > > loosing characters...
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 


