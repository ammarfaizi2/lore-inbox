Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSKOO7W>; Fri, 15 Nov 2002 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSKOO7V>; Fri, 15 Nov 2002 09:59:21 -0500
Received: from pasky.ji.cz ([62.44.12.54]:55790 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S266330AbSKOO7U>;
	Fri, 15 Nov 2002 09:59:20 -0500
Date: Fri, 15 Nov 2002 16:06:10 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: Paul Larson <plars@linuxtestproject.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021115150610.GO2644@pasky.ji.cz>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Paul Larson <plars@linuxtestproject.org>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <225710000.1037241209@flay> <1037310164.10627.121.camel@plars> <1037311755.3180.214.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037311755.3180.214.camel@phantasy>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Nov 14, 2002 at 11:09:15PM CET, I got a letter,
where Robert Love <rml@tech9.net> told me, that...
> On Thu, 2002-11-14 at 16:42, Paul Larson wrote:
> 
> > That being said, I guess this should have been the first question:
> > Should bugs reported to bugme still be posted here (or elsewhere when
> > appropriate)?  I would assume so, at least for a while.
> 
> Yes!
> 
> The bugzilla database is a great idea but it should remain a database
> i.e. a list.  Discussion and the initial reporting of bugs should remain
> on the relevant lists _please_.

What about using the bugzilla email gateway? While it would be feasible that
bugs should be added through the web interface, why not to automagically
forward changes (new comments, attachments, maybe also status?) to appropriate
mailing lists and absorb the replies to the thread back to bugzilla as the new
comments? Ok, this would require people to cut the Cc soon enough not to stack
100-messages thread slowly evolving to completely different topic into bugzilla
;-).

If there is an interest in this and noone else is overly keen to do it, I would
be willing to investigate this and check the functionality of the email gateway
in bugzilla's contrib/ and possibly extend/fix it for our usage.

-- 
 
				Petr "Pasky" Baudis
.
weapon, n.:
        An index of the lack of development of a culture.
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
