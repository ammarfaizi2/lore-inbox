Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281079AbRKOViJ>; Thu, 15 Nov 2001 16:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281081AbRKOVht>; Thu, 15 Nov 2001 16:37:49 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:14723 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S281079AbRKOVhq>;
	Thu, 15 Nov 2001 16:37:46 -0500
Date: Wed, 14 Nov 2001 00:10:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: L A Walsh <law@sgi.com>
Cc: "mike@morpheus" <mike@morpheus.streamgroup.co.uk>,
        Linux-kernel@vger.kernel.org
Subject: Re: mysterious power off problem 2.4.10-2.4.14 on laptop
Message-ID: <20011114001054.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0111122227140.24454-100000@morpheus.streamgroup.co.uk> <3BF039D9.D75809F2@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BF039D9.D75809F2@sgi.com>; from law@sgi.com on Mon, Nov 12, 2001 at 01:06:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Give ACPI a try, for a while I've noticed APM getting mixed up
> > on my home box (its a VIA chipset, I've been told that probably
> > why :), doing things like not powering off and changing the instant-off
> > powerbutton to a wait-5-seconds powerbutton.
> > 
> > I switched to ACPI and everythings been working fine :)
> ---
> 	Thanks for the suggestion.  However APM was working superbly for
> my architecture in 2.4.9 and before.  It turned off the display when I

You don't want to switch to acpi.... Di binary search of which patch broke 
it....
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

