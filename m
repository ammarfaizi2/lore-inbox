Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVC1GKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVC1GKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 01:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVC1GKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 01:10:06 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52960 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261196AbVC1GJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 01:09:53 -0500
Message-Id: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Aaron Gyes <floam@sh.nu>, "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!. 
In-Reply-To: Message from Kyle Moffett <mrmacman_g4@mac.com> 
   of "Sun, 27 Mar 2005 14:30:41 EST." <32bdf7ca3e679d0b61d1ae06d69d1623@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 27 Mar 2005 21:54:09 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> said:
> On Mar 27, 2005, at 14:16, Aaron Gyes wrote:
> > So what? Sure, GPL'd drivers are easier for an end-user in that case.
> > What does that have to do with law?

> Well, under most interpretations of the GPL, you are *NOT* allowed to
> even _link_ non-GPL code with GPL code. (Basically, by distributing such
> a linked binary, you are certifying that you have permission to GPL the
> entire source-code and are doing so.

Wrong. You are free to do whatever you like in the privacy of your home,
but not distribute the result. So you could very well distribute both
pieces, one under GPL, the other not, and leave the linking to the end
user.

Sure, /creating/ the piece to be linked with the GPLed code might make it
GPL also, but that is another story.

> > What about what's better for the company that made the device?

> Who says that free maintenance and bugfixes *isn't* better for said
> company?

Not me. But it is not the only consideration involved.

> > Should NVIDIA be forced to give up their secrets to all their
> > competitors because some over zealous developers say so?

nVidia doesn't want to tell, that is their decision to make. If they don't
tell, Linux users don't get to use nVidia cards with OSS drivers. Both
sides loose something, nVidia thinks (right or wrong) that what they loose
this way is less than what they'd loose by opening up.

> We don't care about their secrets, we just want to be able to interface
> with their hardware.  Really, we don't care how the hardware does what
> it does internally, we just care how to tell it to do that.  It's the
> difference between telling an artist to paint a big picture and
> watching every thought he makes while he does the painting with a brain
> scanner.

That the "Linux kernel community" (whoever that might be) doesn't care
doesn't mean others wouldn't consider mining the Linux drivers for any data
on their competition.

> > Should the end-users of the current drivers be forced to lose out
> > on features such as sysfs and udev compatability?

> Should the end-users even *have* features such as sysfs and udev?  If
> the *open-source* developers hadn't *opened* their *source*, then that
> code wouldn't exist.  One condition they made when they gave that code
> for free was that *only* people who also gave their code for free
> could use it.

Grey area... it could be argued that this is /public/ interfase to the
kernel, and as such shouldn't be closed off.

> > I love Linux, and a I love that free software has become mildly
> > successful, but the zealots are hurting both.

> On the contrary, the zealots are what protect us from the even worse
> proprietary software zealots.  You may not agree with them, but if
> there were only one kind of zealot then the world would be much
> worse off.

As long as the opposing zealots keep each other in check... ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
