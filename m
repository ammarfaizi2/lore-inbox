Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVAKVgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVAKVgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAKVdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:33:47 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:41914 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262876AbVAKVdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:33:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Date: Tue, 11 Jan 2005 22:33:00 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200501112220.53011.rjw@sisk.pl> <20050111212729.GC1802@elf.ucw.cz>
In-Reply-To: <20050111212729.GC1802@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112233.01113.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 11 of January 2005 22:27, Pavel Machek wrote:
> Hi!
> 
> > On 2.6.10-mm2, if swsusp suspends my box on AC power and then it's resumed 
on 
> > batteries, the box reboots after (or while) suspending devices (ie before 
> > restoring the image).  This is 100% reproducible, it appears.
> > 
> > The box is an Athlon 64 laptop on NForce 3.
> 
> Forcing machine to 800MHz before suspend may do the trick, too.

How can I do this?

RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
