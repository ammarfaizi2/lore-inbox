Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSIHSCE>; Sun, 8 Sep 2002 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSIHSCE>; Sun, 8 Sep 2002 14:02:04 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:18048 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S310190AbSIHSCD>;
	Sun, 8 Sep 2002 14:02:03 -0400
Date: Sun, 8 Sep 2002 12:51:13 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: clean before or after dep?
In-Reply-To: <20020908165323.A1262@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0209081248080.1022-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Sam Ravnborg wrote:

> README located in the top-level directory specify:
> make config
> make clean
> make dep
> 
> Which is the logical order if you ask me.
> 
> On Sun, Sep 08, 2002 at 02:13:02PM +0100, Alan Cox wrote:
> > The "kernel-howto" has been badly broken for years. The world would
> > actually be better without that document IMHO
> 
> What about a small HOWTO located in Documentation/ that include a note
> that the LDP HOWTO is outdated?

I can't find the make clean in the top-level directory mentioned above.  
Is the make clean even needed?  I'm not doing a make clean when I rebuild 
kernels; am I making a big booboo?

I'm willing to rewrite the HOWTO, or create a new one if needed.

