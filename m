Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbTC1TZr>; Fri, 28 Mar 2003 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbTC1TZq>; Fri, 28 Mar 2003 14:25:46 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:51865 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263113AbTC1TZq>; Fri, 28 Mar 2003 14:25:46 -0500
Subject: Re: [BUG] laptop keyboard, even more info
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Arne Koewing <ark@gmx.net>
Cc: Warren Turkal <wturkal@cbu.edu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87y92zr57o.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
References: <200303220605.54478.wturkal@cbu.edu>
	 <200303232056.06284.wturkal@cbu.edu>
	 <87y92zr57o.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
Organization: 
Message-Id: <1048880210.598.1.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 28 Mar 2003 20:36:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 10:05, Arne Koewing wrote:
> >> I have tested that the Fn-F2 combination works in bios and grub and
> >> continues to work until the 2.5.65 kernel is loaded.
> >>
> >> I think this is a regression in the keyboard handling for the 2.5.65
> >> kernel....
> 
> I don't think this is caused by the input-layer. Linux is not passing
> Fn-X keypresses to your BIOS. If you've enabled ACPI that ought to be
> the reason for this.

Also, XFree86 4.3.0 seems to inhibit Fn key combinations on some
scenarios. On my laptop, I can't use Fn+F3 to switch between LCD and CRT
while running X.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

