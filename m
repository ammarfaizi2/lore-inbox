Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVC0Tba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVC0Tba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVC0Tba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:31:30 -0500
Received: from smtpout.mac.com ([17.250.248.71]:32755 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261486AbVC0TbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:31:16 -0500
In-Reply-To: <1111951014.9831.4.camel@localhost>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com> <20050327180417.GD3815@gallifrey> <20050327183522.GM4285@stusta.de> <1111951014.9831.4.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32bdf7ca3e679d0b61d1ae06d69d1623@mac.com>
Content-Transfer-Encoding: 7bit
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Sun, 27 Mar 2005 14:30:41 -0500
To: Aaron Gyes <floam@sh.nu>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2005, at 14:16, Aaron Gyes wrote:
> So what? Sure, GPL'd drivers are easier for an end-user in that case.
> What does that have to do with law?

Well, under most interpretations of the GPL, you are *NOT* allowed to
even _link_ non-GPL code with GPL code. (Basically, by distributing such
a linked binary, you are certifying that you have permission to GPL the
entire source-code and are doing so.


> What about what's better for the company that made the device?

Who says that free maintenance and bugfixes *isn't* better for said
company?


> Should NVIDIA be forced to give up their secrets to all their
> competitors because some over zealous developers say so?

We don't care about their secrets, we just want to be able to interface
with their hardware.  Really, we don't care how the hardware does what
it does internally, we just care how to tell it to do that.  It's the
difference between telling an artist to paint a big picture and
watching every thought he makes while he does the painting with a brain
scanner.


> Should the end-users of the current drivers be forced to lose out
> on features such as sysfs and udev compatability?

Should the end-users even *have* features such as sysfs and udev?  If
the *open-source* developers hadn't *opened* their *source*, then that
code wouldn't exist.  One condition they made when they gave that code
for free was that *only* people who also gave their code for free
could use it.


> I love Linux, and a I love that free software has become mildly
> successful, but the zealots are hurting both.

On the contrary, the zealots are what protect us from the even worse
proprietary software zealots.  You may not agree with them, but if
there were only one kind of zealot then the world would be much
worse off.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


