Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSDIWRP>; Tue, 9 Apr 2002 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDIWRO>; Tue, 9 Apr 2002 18:17:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19717 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311866AbSDIWRN>; Tue, 9 Apr 2002 18:17:13 -0400
Date: Wed, 10 Apr 2002 00:17:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.56-2.4.18-15
Message-ID: <20020409221716.GI5148@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020408012536.A329@toy.ucw.cz> <200204092316.SAA05188@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why don't you just feed your /dev/random from hosts /dev/random? 
> 
> That would open up DOS attacks on the host.  A nasty person inside a UML
> could drain the host's /dev/random and hang anything on the host that needs
> random numbers.

Okay, make it /dev/urandom ;-).

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
