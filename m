Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTJNOlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTJNOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:41:32 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:25985 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262434AbTJNOl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:41:26 -0400
Date: Tue, 14 Oct 2003 16:41:24 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Michael Still <mikal@stillhq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
Message-ID: <20031014164124.A2600@beton.cybernet.src>
References: <20031014120946.A4969@beton.cybernet.src> <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com>; from mikal@stillhq.com on Tue, Oct 14, 2003 at 09:16:39PM +1000
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://freshmeat.net/projects/docbook-utils/

Tried this. It wants jade. Installed jade. jade is a X Window
System appliaction. During compilation of
docbook-utils-0.6.13 I got a message:
Gtk-WARNING **: cannot open display:

I am doing this on a router where I have no X server. How can
I view Linux Kernel HTML documentation on a router where I have got only
an ssh access and no X server?

I suggest considering replacing the DocBook bloatware for something
more sane in the kernel tree. You could maybe generate the html
docs yourself and simply put them somewhere into the Documentation/
directory into the kernel sources. Or at least on the web, but then
the people offline couldn't even read the instruction manual for their
kernel.

> Dude, he was just trying to ask what distro you use, in order to help you 
> out. Of course how you install it changes based on the distro you're 
> using.

I don't use any distro. I have compiled my operating system from scratch.

> 
> > If there doesn't exist any distribution-idependent installation process
> > for "DocBook stylesheets", then "DocBook stylesheets" is not portable,
> > and transitively, "Linux Kernel" is not portable.
> 
> Given than most Linux distros are open source themselves, and that the 

Your talk about distros is OT. I don't have any distro. I have built my
system from the source. I just
want to know how to build the kernel HTML docs.

I have built Gnome, Qt, Xfree86, gcc, glibc, j2sdk1.4.1 and mozille from
sources, but haven't used dpkg or rpm yet.

If Linux Kernel is package-only, please tell me. I will do a cat /dev/zero >
/dev/hda then and move on to OBSD then.

> web? For example, a bunch of the kernel API man pages can be found at:
> 
> http://www.stillhq.com/linux/mandocs/
> 
> > Could you please
> > recommend me some other open-source free operating system where I don't
> > need to have a "distribution" to be even able to read it's enclosed
> > documentation? I have been using Linux Kernel for 7 years but can't anymore
> > because I am unable to read it's manual.
> 
> FreeBSD? OpenBSD? NetBSD? Minix? I recommend you look through the list at 
> http://mirror.aarnet.edu.au if you really feel the urge to move on.
> 
> Cheers,
> Mikal
> 
> -- 
> 
> Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
> http://www.stillhq.com            |  to achieve my many goals"
> UTC + 10                          |    -- Homer Simpson
> 
