Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291882AbSBNUxF>; Thu, 14 Feb 2002 15:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291906AbSBNUwQ>; Thu, 14 Feb 2002 15:52:16 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:57872 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291882AbSBNUus>;
	Thu, 14 Feb 2002 15:50:48 -0500
Date: Thu, 14 Feb 2002 09:27:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
Message-ID: <20020214092753.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0202131043230.13632-100000@home.transmeta.com> <3C6AA01A.51517C48@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C6AA01A.51517C48@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 13, 2002 at 12:19:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As an experiment a couple months ago, I got most of the PCI net drivers
> down to ~200-300 lines of C code apiece, by factoring out common code
> patterns into M4 macros.  "m4 netdrivers.m4 epic100.tmpl > epic100.c"

This is slightly extreme, right?

But I'd like to see resulting epic100.tmpl ;-).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

