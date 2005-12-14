Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVLNAZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVLNAZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLNAZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:25:13 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:43350 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932625AbVLNAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:25:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adam Kropelin <akropel1@rochester.rr.com>
Subject: Re: [patch] Giving the reins over to Dmitry
Date: Tue, 13 Dec 2005 19:25:08 -0500
User-Agent: KMail/1.9.1
Cc: Vojtech Pavlik <vojtech@ucw.cz>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20051213195729.A7513@mail.kroptech.com>
In-Reply-To: <20051213195729.A7513@mail.kroptech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131925.09082.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 19:57, Adam Kropelin wrote:
> Andrew Morton wrote:
> > Vojtech Pavlik <vojtech@ucw.cz> wrote:
> >
> >>   INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
> >>  -P:	Vojtech Pavlik
> >>  -M:	vojtech@suse.cz
> >>  +P:	Dmitry Torokhov
> >>  +M:	dtor_core@ameritech.net
> >
> > I guess this means that I should drop http://www.ucw.cz/~vojtech/input/
> > from the -mm lineup?
> 
> Some of those look pretty good, hopefully Dmitry will pick them up?
> Specifically...
> 
>     hid-variable-max-buffer-size.diff 
>     hiddev-sync-after-report-write.diff 
>     hid-no-unplug-on-success.diff
> 
> ...are interesting to me.
>

All of the above have been merged quite some time ago. Do you see anything
missing? 

-- 
Dmitry
