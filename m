Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136479AbRD3IOH>; Mon, 30 Apr 2001 04:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136481AbRD3IN6>; Mon, 30 Apr 2001 04:13:58 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:51420 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136479AbRD3INu>; Mon, 30 Apr 2001 04:13:50 -0400
Message-Id: <5.0.2.1.2.20010430090936.00aeb650@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 30 Apr 2001 09:13:49 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Cc: John Stoffel <stoffel@casc.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010430040304.A5839@thyrsus.com>
In-Reply-To: <5.0.2.1.2.20010430085034.00b0d3b0@pop.cus.cam.ac.uk>
 <5.0.2.1.2.20010430023154.03cd52b0@pop.cus.cam.ac.uk>
 <15084.12152.956561.490805@gargle.gargle.HOWL>
 <20010427193501.A9805@thyrsus.com>
 <15084.12152.956561.490805@gargle.gargle.HOWL>
 <20010429183526.B32748@thyrsus.com>
 <5.0.2.1.2.20010430023154.03cd52b0@pop.cus.cam.ac.uk>
 <20010429214136.A2260@thyrsus.com>
 <5.0.2.1.2.20010430085034.00b0d3b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:03 30/04/2001, Eric S. Raymond wrote:
>Anton Altaparmakov <aia21@cam.ac.uk>:
> > >I tried whitespace, but the default Tkinter font isn't fixed-width.  How
> > >do you do invisible text?
> >
> > Text colour = background colour -> invisible
>
>Well, duh.  Unfortunately, it doesn't seem to have occured to the dozen or
>so people who suggested this that:
>
>(a) Background color can vary depending on how Tk's X resources are set, and
>
>(b) Tk doesn't give me, AFAIK, any way to query either that background color
>     or those resources.

Well, that's a problem with Tk. I did say I know nothing about Tcl and this 
extends to Tcl/Tk...

>Fer cripes' sake.  If it were that easy I'd have *done* it already, people!

Well, you asked a generic question and not one of "how do you do this in 
Tcl/Tk?" so you got a generic reply...

>Anyway my attempts to set a foreground color on an inactive button widget
>failed.  I don't know why.  Tk is full of weird little corners like that.
>
>What I've done is just disabled inactive help buttons without trying to
>hack the text or color. That makes them all the same width, though the
>legend "Help" does show up in gray on the inacive ones.

Cool.

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

