Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUBAHdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 02:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUBAHdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 02:33:24 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:15366 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S265227AbUBAHdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 02:33:23 -0500
To: Rafael Pereira <flip-flop@pop.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no console with current (bk) kernel
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <1075605603.4647.11.camel@fliflop.mosfet.bit> (Rafael Pereira's
 message of "Sun, 01 Feb 2004 01:20:03 -0200")
References: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
	<1075605603.4647.11.camel@fliflop.mosfet.bit>
Date: Sun, 01 Feb 2004 02:33:11 -0500
Message-ID: <m3k737w8y0.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rafael" == Rafael Pereira <flip-flop@pop.com.br> writes:

>> and yet the boot fails with a complaint that it cannot open a
>> console, followed by a reboot.  (Too fast to copy anything down.)

Rafael> Did you enabled the: CONFIG_FRAMEBUFFER_CONSOLE=y ???

No, I have CONFIG_FB is not set, so that option doesn't show up.

I do prefer to not use the FB on this box; I've had some bad
interactions between (radeonfb or vesafb) and X.

Rafael> try to enable it.

I will give a test w/ a fb, just to confirm whether that matters.

-JimC

