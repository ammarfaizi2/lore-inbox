Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTL0Woy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTL0Woy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 17:44:54 -0500
Received: from web40612.mail.yahoo.com ([66.218.78.149]:45599 "HELO
	web40612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264873AbTL0Wow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 17:44:52 -0500
Message-ID: <20031227224451.73330.qmail@web40612.mail.yahoo.com>
Date: Sat, 27 Dec 2003 23:44:51 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: 2.6.0 sound output - wierd effects
To: Rob Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1072501808.4136.6.camel@fur>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Rob Love <rml@ximian.com> a écrit : > On Sat, 2003-12-27 at
00:02, Martin J. Bligh wrote:
> 
> > Because someone broke it ... that's what this thread is
> about ;-)
> 
> Right, sorry :-)
> 
> But what does that have to do with OSS remaining in the kernel
> and the
> guy I was responding to having to continue to use OSS?
> 
> I mean, it is a bug, and we will fix it.  Keeping OSS is
> orthogonal. 
> That was my point.
> 

The problem is that alsa is not stable. At least not like oss.
I switched from alsa to oss because i could compile oss
directly in my kernel
 (that was a long time ago).

and when 2.6.0-test apeared i compiled alsa in the kernel but i
had
problems with it and came back to oss:
1. SOund was jerky compared to oss (almost inaudible)
with oss emulation.
2. doesn't have an btaudio driver and i wasn't been able to
compile alsa and oss btaudio driver in the same kernel 
so i couldn't watch tv with the alsa kernel :-(
3. Many old sound applications require oss (even emulated)
And oss emulation is far from stable. 

These are my opinions. I hope they will change soon :-)

> 	Rob Love
> 
Calin


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

_________________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
