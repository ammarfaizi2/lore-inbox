Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269713AbUISHvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269713AbUISHvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 03:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUISHvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 03:51:31 -0400
Received: from web52808.mail.yahoo.com ([206.190.39.172]:39816 "HELO
	web52808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269713AbUISHv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 03:51:28 -0400
Message-ID: <20040919075128.34712.qmail@web52808.mail.yahoo.com>
Date: Sun, 19 Sep 2004 00:51:28 -0700 (PDT)
From: mike cox <mikecoxlinux@yahoo.com>
Subject: Re: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
To: linux-kernel@vger.kernel.org
Cc: mike cox <mikecoxlinux@yahoo.com>
In-Reply-To: <200409190207.27604.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Saturday 18 September 2004 10:43 pm, Dmitry
> Torokhov wrote:
> > I will try Google for them later. They are pretty
> new, SuSE 8.2 would
> > not have them. 
> 
> Ok, here is what I found:
> 
> The patch for hid-input to convert tilt events to
> HWHEEL:
> 
>
http://www.t12.jp/~ryuta/misclab/debian/release/hidinput-tiltwheel-quirk-for-linux-2.6.7.patch
> 
> I am not sure who the author is as I do not know
> Japanese.
> 
> The patches for XFree86/XOrg allowing to get data
> from /dev/input/eventX
> can be extracted from the floowing:
> 
>
http://cudlug.cudenver.edu/gentoo/distfiles/xorg-x11-6.8.0-patches-0.2.tar.bz2
> 
> Look for patches 9000, 9001 and 9002. As far as I
> can see it will allow using
> wheel to do horizontal scrolling as well.

My warmest thanks to you Dmitry.  I don't know how you
found these tilt wheel drivers, but it has been most
helpful to me and perhaps many others with tilt
wheels.

Once again, thank you very much. :-).  


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
