Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDCHjY>; Tue, 3 Apr 2001 03:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRDCHjO>; Tue, 3 Apr 2001 03:39:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57870 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132686AbRDCHjD>; Tue, 3 Apr 2001 03:39:03 -0400
Message-ID: <3AC97AF0.C5D6EDA7@evision-ventures.com>
Date: Tue, 03 Apr 2001 09:25:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14kAWs-0006cZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > So change them as well for a new distribution. What's there problem.
> > There isn't anything out there you can't do by hand.
> > Fortunately so!
> 
> So users cannot go back and forward between new and old kernels. Very good.
> Try explaining that to serious production -users- of a system and see how
> it goes down

If anything I'm a *SERIOUS* production user. And I wouldn't allow
*ANYBODY* here to run am explicitly tagged as developement kernel
here anyway in an production enviornment. That's what releases are for
damn.
Or do you think that Linux should still preserve DOS compatibility
in to the eternity as other "popular" systems do?
