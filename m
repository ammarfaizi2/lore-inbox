Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTAHL3p>; Wed, 8 Jan 2003 06:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTAHL3p>; Wed, 8 Jan 2003 06:29:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39654 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266995AbTAHL3o>;
	Wed, 8 Jan 2003 06:29:44 -0500
Date: Wed, 8 Jan 2003 11:35:53 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, jeff gerard <jeff-lk@gerard.st>
Subject: Re: [PATCH][TRIVIAL] menuconfig color sanity
Message-ID: <20030108113553.GA21198@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, jeff gerard <jeff-lk@gerard.st>
References: <20030108104714.GM268@gage.org> <200301081205.04849.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301081205.04849.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:05:04PM +0100, Marc-Christian Petersen wrote:

 > > using yellow and green text with a "white" background in menuconfig works
 > > all right on console, but it looks like crap under xterm, rxvt, etc. no
 > > matter whose fault that is, the trivial patch below makes things more
 > > readable without any major change in appearance. applies to 2.4 and 2.5.
 > > now you can stop wondering about support for "lug and play", "mateur
 > > radio", and "elephony" in the linux kernel.
 > huh? I can see Plug and Play, Amateur Radio and Telephony very well also in a 
 > XTERM etc. I don't know where you have any problems with those colors.
 > Prolly your xterm etc. are faulty ;)

Different monitors, different graphic cards, different eyes.
All these things offer variation in colour, and yellow text
on a light grey background wasn't exactly a wise choice from
a readability point of view.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
