Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWA3V5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWA3V5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWA3V5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:57:08 -0500
Received: from mail.gmx.net ([213.165.64.21]:49113 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932386AbWA3V5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:57:07 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 22:57:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Albert Cahalan <acahalan@gmail.com>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060130215701.GA10312@merlin.emma.line.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com> <43D8D396.nailE2X31OHFU@burner> <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com> <43DE8A06.9010800@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DE8A06.9010800@tmr.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, Bill Davidsen wrote:

> Just to be clear, Joerg is not the only one I think has been a problem 
> here, he pissed off some of the developers who don't seem overly eager 
> to do things which would be helpful for any burner software. From here 
> it looks like a pissing content, with users well within splash range.

Well, Jörg is not giving us answers to the extent that might convince a
Linux kernel hacker to change things, except for a few handrails besides
the staircase, such as Ted's suggestion WRT RLIMIT_MEMLOCK, or people
offering to fix ide-tape to talk SG_IO - Jörg however has not yet
documented how ide-tape fixes are relevant for the CD writing
application (no doubt that a SCSI /GENERAL/ interface library has
interest in such, it does not matter to the CD writing topic).

> Look a year down the road, when we have have two (or more) new 25GB 
> optical formats coming out, probably with new features and commands and 
> several vendors building drives for them. Both formats have DRM stuff in 
> them, and GPL 3 forbids implementing DRM (simplification).

I find it fascinating that everyone talks about the first public GPL v3
draft as though it were the final version. Now is the time to express
concerns, for instance, the GPL's incompatibility, to the FSF.

And no, I do not have current plans to work on a cdrecord fork as it is.

-- 
Matthias Andree
