Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVDLX0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVDLX0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVDLXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:21:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17806 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263048AbVDLXUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:20:23 -0400
Date: Wed, 13 Apr 2005 01:20:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Bill Davidsen <davidsen@tmr.com>, junkio@cox.net, dlang@digitalinsight.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-ID: <20050412232003.GB24414@elf.ucw.cz>
References: <7vzmw7as25.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.3.96.1050410124238.18440A-100000@gatekeeper.tmr.com> <20050410105003.10e49ea0.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410105003.10e49ea0.pj@engr.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It's possible to generate another object with the same hash, but:
> 
> Yeah - the real check is that the modified object has to
> compile and do something useful for someone (the cracker
> if no one else).
> 
> Just getting a random bucket of bits substituted for a
> real kernel source file isn't going to get me into the
> cracker hall of fame, only into their odd-news of the
> day.

I actually two different files with same md5 sum in my local CVS
repository. It would be very wrong if CVS did not do the right thing
with those files.

Yes, I was playing with md5, see "md5 to be considered harmfull
today". And I wanted old version of my "exploits" to be archived.
 
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
