Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUJXKmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUJXKmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUJXKmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:42:49 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:29969 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261435AbUJXKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:39:26 -0400
Date: Sun, 24 Oct 2004 12:45:20 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041024104520.GB12665@hh.idb.hist.no>
References: <4176E08B.2050706@techsource.com> <9e4733910410201808c0796c8@mail.gmail.com> <Pine.GSO.4.61.0410222209410.11567@waterleaf.sonytel.be> <417984A9.2070305@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417984A9.2070305@techsource.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 06:07:37PM -0400, Timothy Miller wrote:
> 
> 
> Geert Uytterhoeven wrote:
> >On Wed, 20 Oct 2004, Jon Smirl wrote:
> >
> >>If you implement VGA you will be able to boot and work in any x86
> >>system without writing any code other than the BIOS.
> >
> >
> >Ugh... I prefer _not_ to have VGA compatibility.
> 
> Well, some people agree with you, but if I can squeeze it small enough, 
> it's worth having because it maximized compatibility.  It's vital for 
> x86 consoles.

I can't see how it is "vital", or even makes a difference at all.
Other than upping the price a bit.  The pc doesn't need VGA compatibility
to boot - because you supply a video bios.  The mainboard bios
uses the video bios. (There have been pc's with ibm-incompatible
displays before)
Linux d(and other open os'es) doesn�'t need VGA at all, because 
you supply docs.  You probably won't even have to write the driver
yourself.
Windows doesn't need VGA - if you supply a windows driver.  That
shouldn�'t be hard to do.  

Now, what's left? :-)

Helge Hafting
