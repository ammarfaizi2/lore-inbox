Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUISD0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUISD0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 23:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269737AbUISD0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 23:26:18 -0400
Received: from web52805.mail.yahoo.com ([206.190.39.169]:56992 "HELO
	web52805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269137AbUISD0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 23:26:14 -0400
Message-ID: <20040919032613.96799.qmail@web52805.mail.yahoo.com>
Date: Sat, 18 Sep 2004 20:26:13 -0700 (PDT)
From: mike cox <mikecoxlinux@yahoo.com>
Subject: Re: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
To: linux-kernel@vger.kernel.org
Cc: mike cox <mikecoxlinux@yahoo.com>
In-Reply-To: <200409182128.19138.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Saturday 18 September 2004 08:51 pm, mike cox
> wrote:
> > I'm modifying Vojtech Pavlik's 2.6.8.1 kernel
> > mousedev.c mouse driver to support the new "Tilt
> > wheel" functionality on the Logitech MX1000 Laser
> > Mouse, and the Microsoft Wireless Optical mouse
> with
> > Tilt Wheel Technology.
> 
> How will the tilt information be exported? And what
> is wrong with using
> event interface? I think that the evdev patches are
> included into X shipped
> by Gentoo, Mandrake and Fedora at least...

I'm using SuSE 8.2 with the 2.6.8.1 kernel.  I ran xev
on my machine and it didn't detect any tilting at all.

I asked around on some various newsgroups and there
was not a lot of interest in the logitech and
Microsoft mice that have tilt wheels.  This patch was
going to be for myself and all the other small
minority of tilt wheel mouse users.

If you have a better way, that is why I'm asking for
suggestions.  Please give them, or tell me if I've
overlooked something. 


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
