Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRDCM2U>; Tue, 3 Apr 2001 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRDCM2M>; Tue, 3 Apr 2001 08:28:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18705 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131654AbRDCM1P>; Tue, 3 Apr 2001 08:27:15 -0400
Message-ID: <3AC9BE72.9C2D3C9@evision-ventures.com>
Date: Tue, 03 Apr 2001 14:13:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14kPmQ-0007vt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If anything I'm a *SERIOUS* production user. And I wouldn't allow
> > *ANYBODY* here to run am explicitly tagged as developement kernel
> > here anyway in an production enviornment. That's what releases are for
> > damn.
> > Or do you think that Linux should still preserve DOS compatibility
> > in to the eternity as other "popular" systems do?
> 
> You still break 2.4-2.6. Thats a production release jump. Right now I can
> and do run 2.0->2.4 on the same box. If you dont understand why to many
> people that is a requirement please talk to folks who run real business on
> Linux

You have possible no imagination about how real the business is I do
:-).
What's worth it to be able running 2.0 and 2.4 on the same box?
I just intendid to tell you that there are actually people in the
REAL BUSINESS out there who know about and are willing to sacifier
compatibility until perpetuum for contignouus developement.

BTW we don't run much of Cyrix486 hardware anymore here.. More like
boxes with few gigs of ram 4 CPU's RAID and so on...
The single biggest memmory hog here is currently the Oracle 9i AS.
