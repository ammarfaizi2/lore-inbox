Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVAJPya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVAJPya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVAJPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:54:29 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:40842 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262305AbVAJPxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:53:38 -0500
Date: Mon, 10 Jan 2005 07:53:26 -0800 (PST)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@antonia.sgowdy.org
Reply-To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
To: Roseline Bonchamp <roseline.bonchamp@gmail.com>
cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] USB problem with a mass storage device on
 2.6.10
In-Reply-To: <884a349a050110044654d75f7b@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0501100752270.5108@antonia.sgowdy.org>
References: <884a349a050110044654d75f7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is in /proc/bus/usb/devices when it doesn't work (and when it works)?
What command fails?

On Mon, 10 Jan 2005, Roseline Bonchamp wrote:

> Hello,
>
> I have a PQI 1GB Intelligent Stick, which does'nt work most of the
> time on 2.6.10 (sometime when I plug/unplug it does work, but most of
> the time it does'nt)
>
> When it does not work, I see this when I plug it:
>
> kernel: usb 1-3: new high speed USB device using ehci_hcd and address 6
> kernel: usb 3-1: new full speed USB device using uhci_hcd and address 4
> kernel: usb 3-1: new full speed USB device using uhci_hcd and address 5
>
> When it does work, I only see the first one (high speed), and then USB
> mass storage stuff.
>
> On kernel 2.6.9 it does work, but seems to produce a kernel crash (log
> attached) (but I still can use it and mount it)
>
> I tried on a knoppix 3.6 (2.6.7, not vanilla) kernel, and it seems to work too.
>
> Even with 2.6.10 I have no problem with some other USB mass storage devices.
>
> I already did a post about this, but the subject of the mail was wrong
> (sorry), and it was not mailed to linux-usb:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0501.1/0371.html
>
> Regards,
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
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
