Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290919AbSBQKpG>; Sun, 17 Feb 2002 05:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292921AbSBQKo4>; Sun, 17 Feb 2002 05:44:56 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:10508 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S290919AbSBQKoh>;
	Sun, 17 Feb 2002 05:44:37 -0500
Date: Sat, 16 Feb 2002 23:46:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020216224618.GB602@elf.ucw.cz>
In-Reply-To: <20020215204510.GD5019@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.10.10202151719420.10501-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202151719420.10501-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have looked over it and it seems reasonable and sane, and thanks for the
> input but the timing is woefully wrong.  The multi-mode write is wrong by
> the requirements of Linus.  I just now have a possible solution.
> Could we just hold off until I fix the core?

I do not think it would be good idea.

That code needs to be cleaned up. Everything will be easier when it is
clean.

Sorry.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
