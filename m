Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTG0QpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTG0QpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:45:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28359 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270857AbTG0QpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:45:11 -0400
Date: Sun, 27 Jul 2003 19:00:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030727170019.GU22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net> <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 05:40:18PM +0100, Alan Cox wrote:
> On Sul, 2003-07-27 at 16:59, David D. Hagood wrote:
> > This is a pet peeve of mine on Free Software projects in general - The 
> > Program That Wouldn't Compile.
> > 
> > It would seem to me that in the context of the kernel, what is needed is 
> > a BROKEN flag.
> 
> We've had one for years. Its CONFIG_OBSOLETE, its even used in 2.6test

Disclaimer:
I'm not a native English speaker.

In my ears, "obsolete" sounds like "there's something newer instead" and 
"broken" sounds like "it doesn't work at the moment".

This might be wrong, but if it's right I do prefer BROKEN.

Anyway, it's not that important whether OBSOLETE or BROKEN is used.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

