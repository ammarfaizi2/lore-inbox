Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTA1Nhk>; Tue, 28 Jan 2003 08:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTA1Nhj>; Tue, 28 Jan 2003 08:37:39 -0500
Received: from [195.72.113.150] ([195.72.113.150]:38668 "EHLO
	schubert.rdns.com") by vger.kernel.org with ESMTP
	id <S264954AbTA1Nhi>; Tue, 28 Jan 2003 08:37:38 -0500
Date: Tue, 28 Jan 2003 13:46:54 +0000 (GMT)
From: Robert Morris <rob@effective-it.co.uk>
X-X-Sender: rob@schubert.rdns.com
To: Stefan Reinauer <stepan@suse.de>
cc: Robert Morris <rob@r-morris.co.uk>,
       Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <20030128133252.GC23296@suse.de>
Message-ID: <Pine.LNX.4.44.0301281336410.22665-100000@schubert.rdns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

On Tue, 28 Jan 2003, Stefan Reinauer wrote:

> Seeing the same "Oh, I got my name and
> copyright visible in this and that driver" every time I boot a system
> is about as lame

Agreed

> people who think different. Don't call them lame. 

That's *not* what I said!

> Make it configurable, so that everybody can turn it on and off, and
> don't turn it on by default. This is done with the fbcon stuff anyways,
> which is mandatory for a splash screen. Where's the problem in just not
> switching such a function on? 

The distribution vendors will turn it on by default - as already happened 
with graphical bootloader screens, for example - and then the majority of 
users will not turn it off. Then it will become the norm...

Most Windows users notionally have the choice to download another web 
browser such as Mozilla. But how many actually do, when Internet Explorer 
is installed already? The consequence of this is that, de facto, IE 
becomes the predominant browser, then web developers disregard support of 
other browsers, and then users of Mozilla are stuck.

Your point that everyone has a choice is correct in theory, but does not 
take into account the very great power of influence that software 
distributors (be they Microsoft, Red Hat, or Suse) have. Yes, Linux should 
be a platform where people have a choice - but lets make the default 
option a sensible one, and not simply copy as much of the Windows/Mac OS 
environment as possible to try to gain favour with users of those 
platforms, at the expense of our own user community.

The day when a default Red Hat install covers up all the startup output 
with a pretty graphic will be a very sad one indeed for me.


Robert Morris
08707 458710
http://www.r-morris.co.uk/

