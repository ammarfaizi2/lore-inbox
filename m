Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSCLXIk>; Tue, 12 Mar 2002 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSCLXIb>; Tue, 12 Mar 2002 18:08:31 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:6152 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S287862AbSCLXIZ>;
	Tue, 12 Mar 2002 18:08:25 -0500
Date: Tue, 12 Mar 2002 01:48:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020312014824.D37@toy.ucw.cz>
In-Reply-To: <E16kT8L-00014f-00@the-village.bc.nu> <3C8CE34B.4030800@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C8CE34B.4030800@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Mar 11, 2002 at 06:03:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > management commands. Win 98 didnt quite get it right and you'll find one
> > of the updates addresses IDE problems. Ironically fixing the same flush
> > cache and shut down politely problem you plan to break in Linux
> 
> No, the problem *is there* Pavel just attempts to FIX IT and I do
> nothing but supporting him on this. You can hardly claim that

Actually, problem is not yet there, because current S3 sleep is so broken
it is *very* likely to crash your box (and thereby save your data). But when
S3 is repaired, this code is going to be needed.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

