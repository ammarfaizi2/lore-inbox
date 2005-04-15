Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVDOOvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVDOOvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVDOOvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:51:04 -0400
Received: from mailgate04.slac.stanford.edu ([134.79.18.85]:51930 "EHLO
	mailgate04.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S261808AbVDOOu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:50:57 -0400
Date: Fri, 15 Apr 2005 07:50:15 -0700 (PDT)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@localhost
Reply-To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
To: Joerg Pommnitz <pommnitz@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>,
       linux-usb-user <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] 2.6 PCMCIA/USB question
In-Reply-To: <20050415082048.1497.qmail@web51409.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0504150749200.3333@localhost>
References: <20050415082048.1497.qmail@web51409.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Apr 2005 14:50:20.0201 (UTC) FILETIME=[72044990:01C541CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trial and error (and hope they are always the same, which I think they
are with 2.6).

On Fri, 15 Apr 2005, Joerg Pommnitz wrote:

> Hello all,
> I have a question that I could not figure out from other sources. I have
> the following hardware: an integrated CardBus USB host adapter with a
> connected USB serial device with three interfaces (normally
> ttyUSB0...ttyUSB2). Now I want to use 3 of these devices (remember: they
> are integrated, so I can't just plug the USB device onto the same host
> adapter). I know device A is in CardBus slot 1, device B is in CardBus
> slot 2 and so on.
>
> Now the question: How do I figure out which ttyUSBx belongs to which
> device?
>
> Thanks in advance
>   Joerg
>
>
>
>
>
>
> ___________________________________________________________
> Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
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
