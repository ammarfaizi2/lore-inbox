Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWFNKUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWFNKUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFNKUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:20:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:41135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932115AbWFNKUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:20:23 -0400
X-Authenticated: #428038
Date: Wed, 14 Jun 2006 12:20:18 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Neil Brown <neilb@suse.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bernd Petrovitsch <bernd@firmix.at>,
       David Schwartz <davids@webmaster.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>, jdow <jdow@earthlink.net>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060614102018.GA22931@merlin.emma.line.org>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Bernd Petrovitsch <bernd@firmix.at>,
	David Schwartz <davids@webmaster.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	jdow <jdow@earthlink.net>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com> <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at> <AC44C19E-109F-4DD4-933E-B641BF3BF9CB@mac.com> <17551.21000.94210.883031@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17551.21000.94210.883031@cse.unsw.edu.au>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown schrieb am 2006-06-14:

> But I'm sure if that happened you could find a way.

So SPF followers must try talk their way out of responsibility for the
nonsense they create(d) or advocate(d). "I'm sure you can", "Your ISP
must", "You must not" and thereabouts don't work, because...

> The 'best' way would be for mac.com (and everyone else) to accept mail
> submission (and only authenticated mail submission) on the
> 'submission' port (which is an IETF standard RFC2476).
> Then port-25 blocking wouldn't be a problem for you.

...RFC-2476 isn't a mandatory standard as in "every ISP must offer
submission service"

> Now, it could be that SPF might become a standards-track RFC.  And if
> it did (may not be likely, but should be seen as possible as a lot of
> people are pushing despite the fact that many push back) then people
> would feel justified in implementing it and you might start to find
> your mail isn't getting through.

Is anyone really thinking sabotaging technical systems is a good way to
solve social problems?

> 		  Don't be held hostage by your ISP.
> 	   Insist on using 'submission' for mail submission.

Perhaps if people stopped being so narrow-minded to think that looking
at the envelope were a good way to separate the chaff from the wheat, it
might work. Much sooner than killing accessbility and negating SPF
responsibility by trying to coerce people who live somewhere in the
outback and have no choice of ISP into changing ISP or other nonsense.

-- 
Matthias Andree
