Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265548AbRF1FzN>; Thu, 28 Jun 2001 01:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265550AbRF1FzC>; Thu, 28 Jun 2001 01:55:02 -0400
Received: from vitelus.com ([64.81.36.147]:24838 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S265548AbRF1Fyt>;
	Thu, 28 Jun 2001 01:54:49 -0400
Date: Wed, 27 Jun 2001 22:54:21 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>, alan@lxorguk.ukuu.org.uk,
        jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010627225421.A23843@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106271348420.24832-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 01:50:28PM -0700, Linus Torvalds wrote:
> How about we drop the "printk" altogether, and make it all a comment?

Can we please also drop annoying static informational printk's?



> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039

The later line is not something of interest to most people, and if it
happens to be they can research it rather than being force-fed history
on bootup.

> POSIX conformance testing by UNIFIX

Ditto.

> usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
> usb-uhci.c: USB Universal Host Controller Interface driver

How about "usb-uhci.c: USB Universal Host Controller Interface driver v1.251"
instead?

dmesg buffer space is rather limited and IMHO there isn't space to
waste on credit-giving in boot logs.
