Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRBDGeY>; Sun, 4 Feb 2001 01:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130060AbRBDGeO>; Sun, 4 Feb 2001 01:34:14 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:64795 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129601AbRBDGeB>; Sun, 4 Feb 2001 01:34:01 -0500
Message-Id: <200102040727.f147RAQ14787@513.holly-springs.nc.us>
Subject: Re: "kaweth" usb ethernet driver in 2.4?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Eric Sandeen <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A7C686A.2B69D222@sgi.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 04 Feb 2001 01:32:34 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Feb 2001 14:22:02 -0600, Eric Sandeen wrote:

> The driver is included with the USB stuff for 2.2, but not in 2.4.


That's because we stopped fooling with 2.4 around the middle of the
pre-test-ac series of releases. We'll probably pick it back up around
2.4.7 or so.


> It also doesn't seem to work in 2.2.  :)  The original development of
> this driver was going on at http://drivers.rd.ilan.net/kaweth/ but there
> have been no updates for quite some time.


Well, it doesn't work you _you_ on 2.2, obviously. But it works for us
and other people. Can you provide any information to diagnose the
problem you're having?

And, truthfully, you'd be better off tossing it in the trash and buying
a better product. It's VERY lossy with packets and slow. And it's not
just our driver; it's the device itself. It sucks on Windows as well. :)

However, if you post some info about your experience with it, perhaps we
can get it working for you. But not on 2.4 for awhile.

-M

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
