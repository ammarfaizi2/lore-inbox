Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKMVyh>; Tue, 13 Nov 2001 16:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKMVy1>; Tue, 13 Nov 2001 16:54:27 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:63874 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S279429AbRKMVyX>;
	Tue, 13 Nov 2001 16:54:23 -0500
Date: Tue, 13 Nov 2001 01:08:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trivial patch to support for "ACPI" keys in pc_keyb.c
Message-ID: <20011113010817.B37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0111120858430.1901-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111120858430.1901-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Mon, Nov 12, 2001 at 09:08:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I know this should normally be done with setkeycodes but it seems pretty
> harmless to have them in pc_keyb.c and doesn't stomp (i think) on any of
> the other entries. I have these keys on both my BTC keyboards and some
> noname brand keyboards too and they seem to correspond to the proper keys.

These keys are common on recent keyboards so I'd vote for adding this.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

