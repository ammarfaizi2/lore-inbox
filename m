Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291278AbSAaUhD>; Thu, 31 Jan 2002 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291280AbSAaUgv>; Thu, 31 Jan 2002 15:36:51 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:4357 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291278AbSAaUgl>;
	Thu, 31 Jan 2002 15:36:41 -0500
Date: Tue, 29 Jan 2002 13:05:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020129130550.B47@toy.ucw.cz>
In-Reply-To: <20020124002342.A630@earthlink.net> <E16VIO8-0000CO-00@starship.berlin> <20020129004001.F1309@athlon.random> <E16VLvU-0000Du-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16VLvU-0000Du-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Jan 29, 2002 at 01:15:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've also to say I always mke2fs first when I run my benchmarks,
> 
> Yes, and it would be nice if we had an operation to squeeze cache down to
> its minimum size (whatever that means) just for running benchmarks
> accurately without rebooting.

Take a look at swsusp -- it frees as much memory as possible before
doing anything.
								Pavel 
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

