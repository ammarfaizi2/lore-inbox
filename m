Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVC0Thi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVC0Thi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVC0Thi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:37:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36367 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261490AbVC0The (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:37:34 -0500
Date: Sun, 27 Mar 2005 21:37:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Aaron Gyes <floam@sh.nu>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327193733.GN4285@stusta.de>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com> <20050327180417.GD3815@gallifrey> <20050327183522.GM4285@stusta.de> <1111951014.9831.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111951014.9831.4.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 11:16:54AM -0800, Aaron Gyes wrote:
> > And then the user want to upgrade the 2.0 kernel that shipped with this 
> > box although the company that made the hardware went bankrupt some years 
> > ago.
> > 
> > If the user has the source of the driver, he can port the driver or hire 
> > someone to port the driver (this "obscure piece of hardware" might also 
> > be an expensive piece of hardware).
> 
> So what? Sure, GPL'd drivers are easier for an end-user in that case.
> What does that have to do with law? What about what's better for the

I wasn't talking about legal issues.

I was answering Dave's "very specialist piece of equipment" opinion.

And my point was that even in this case it's better for the user to have 
the source.

> company that made the device? Should NVIDIA be forced to give up their
> secrets to all their competitors because some over zealous developers
> say so? Should the end-users of the current drivers be forced to lose
> out on features such as sysfs and udev compatability?
> 
> I love Linux, and a I love that free software has become mildly
> successful, but the zealots are hurting both.

There are many bug reports to linux-kernel that are undebuggable because 
they involve the nvidia binary-only module.

I do personally know several people who use the nvidia binary-only 
modules and have as a result experienced stability problems on their 
computer. Linux has an IMHO justified reputation for being stable.
Users experiencing system stability problems due to binary-only modules 
might wrongfully attribute them to Linux harming the reputation of 
Linux.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

