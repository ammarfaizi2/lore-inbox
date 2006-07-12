Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWGLMjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGLMjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGLMjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:39:19 -0400
Received: from mail.gmx.de ([213.165.64.21]:55730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751264AbWGLMjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:39:19 -0400
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, akpm@osdl.org,
       johnstul@us.ibm.com
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 12 Jul 2006 14:39:17 +0200
From: "Uwe Bugla" <uwe.bugla@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0607121410580.12900@scrub.home>
Message-ID: <20060712123917.18970@gmx.net>
MIME-Version: 1.0
References: <20060712115110.292550@gmx.net>
 <Pine.LNX.4.64.0607121410580.12900@scrub.home>
Subject: Re: Re: patch for timer.c - two dmesgs
To: Roman Zippel <zippel@linux-m68k.org>
X-Authenticated: #8359428
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-------- Original-Nachricht --------
Datum: Wed, 12 Jul 2006 14:17:04 +0200 (CEST)
Von: Roman Zippel <zippel@linux-m68k.org>
An: Uwe Bugla <uwe.bugla@gmx.de>
Betreff: Re: patch for timer.c - two dmesgs

> Hi,
> 
> On Wed, 12 Jul 2006, Uwe Bugla wrote:
> 
> > Then the boot process does not take any break at all (like in kernel
> 2.6.18-rc1 and in kernels 2.6.17-mm*), but simply stops completely.
> > About 7 message lines are missing before X starts for presenting the
> graphical login prompt (proftpd, xprint etc.).
> > Perhaps two dmesgs help: one for a functionable 2.6.17.4 kernel
> (dmesg17), another for the kernel in question (dmesg18).
> 
> A lot has changed since then...
> Did you try using SysRq+P or Alt+ScrollLock? (A SysRq+T might be useful 
> too).
Sorry for this stupid sounding question:
At what point of the boot process do I have to use those keyboard combinations please? And what is the output / product of them please?
Sorry if I simply lack experience in those questions.
> 
> > Simply my intuition tells me that a system timer performs very different
> > on two very different machines with two very different CPU frequencies 
> > and two very different main processors. 
> 
> No offense, it's no intuition, but a shot in the dark.
> If you at least tried a few more kernels (at least 2.6.18-mm1 and 
> 2.6.18-mm2), it would be a much better indication whether it's the timer 
> patch.
> 
> bye, Roman

-- 


Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
