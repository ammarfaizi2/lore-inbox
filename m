Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUGAPT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUGAPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUGAPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:19:27 -0400
Received: from mailgate01.slac.stanford.edu ([134.79.18.80]:55258 "EHLO
	mailgate01.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S265893AbUGAPTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:19:25 -0400
Date: Thu, 1 Jul 2004 08:19:06 -0700 (PDT)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@antonia.sgowdy.org
Reply-To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
To: Duncan Sands <baldrick@free.fr>
cc: linux-usb-users@lists.sourceforge.net, janne <sniff@xxx.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption &
 lockups & poor performance
In-Reply-To: <200407011623.09559.baldrick@free.fr>
Message-ID: <Pine.LNX.4.58.0407010817440.4677@antonia.sgowdy.org>
References: <Pine.LNX.4.40.0407010017360.1548-100000@xxx.xxx>
 <200407010904.39925.baldrick@free.fr> <Pine.LNX.4.58.0407010704570.4677@antonia.sgowdy.org>
 <200407011623.09559.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally I assume Mb/s is mega-bits and MB/s is mega-bytes. Of course I
guess the author of the post should clarify if I've made the wrong
assumption (and you didn't).

On Thu, 1 Jul 2004, Duncan Sands wrote:

> On Thursday 01 July 2004 16:06, Stephen J. Gowdy wrote:
> > On Thu, 1 Jul 2004, Duncan Sands wrote:
> >
> > > > First of all, usb2 throughput was disappointing, i only got about
> > > > 5-15MB/s (usually about 8MB/s) while the manufacturer claims sustained
> > > > datarate of 35MB/s.
> > >
> > > Are you sure you plugged your device into a usb 2 port, and not a usb
> > > 1.1 port? Also, some products claim to be usb 2 devices, when they are
> > > in fact only usb 1.1.
> >
> > 1.1 devices would only get less than 1MB/s.
>
> Ah, I misread it as 8 M bits / s, which is max 1.1 speed.
>
> Bye, Duncan.
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> digital self defense, top technical experts, no vendor pitches,
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Linux-usb-users@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-users
>

--
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/
