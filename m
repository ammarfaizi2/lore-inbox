Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbUAPSXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUAPSXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:23:14 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:46208 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265677AbUAPSXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:23:10 -0500
Date: Fri, 16 Jan 2004 19:23:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Karl Dahlke <eklhad@comcast.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH, accessibility, adaptive modules, 2.6.0
Message-ID: <20040116182303.GB924@elf.ucw.cz>
References: <S265137AbUAKN4r/20040111135647Z+27556@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S265137AbUAKN4r/20040111135647Z+27556@vger.kernel.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Type of change:
> 
> Make LInux easily accessible to people with various disabilities.
> 
> I can tell you, from personal experience,
> that trying to patch and build and install a new kernel,
> *before* I receive any feedback whatsoever from the computer,
> is nearly impossible.
> Yet that's what we must do today, if we want a kernel-resident adapter.
> 
> This patch has been "in the works" for four years,
> and I have used the system, 8 hours a day, for all that time.
> Of course it has moved through many versions.
> This is the patch for version 2.6.0.
> 
> Note that this patch does not install any specific adapters.
> Rather, it makes the kernel "accessible".
> Thus it is ready for adaptive modules,
> just as the kernel stands ready to acccept ethernet drivers,
> sound card drivers, etc.

Why is not handled same way as - say - serial console? Accessible
kernel seems pretty similar to kernel running with console over serial
port... Big infrastructure should not be needed.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
