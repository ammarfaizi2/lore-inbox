Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTBTWk5>; Thu, 20 Feb 2003 17:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTBTWk5>; Thu, 20 Feb 2003 17:40:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6273 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S267048AbTBTWky>;
	Thu, 20 Feb 2003 17:40:54 -0500
Subject: Re: 2.5.60 cheerleading...
From: "Timothy D. Witham" <wookie@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Larson <plars@linuxtestproject.org>,
       John Bradford <john@grabjohn.com>, davej@codemonkey.org.uk,
       edesio@ieee.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
In-Reply-To: <20030220224225.GU9800@gtf.org>
References: <200302131823.h1DINeZh016257@darkstar.example.net>
	 <1045170999.28493.57.camel@plars> <20030213213850.GA22037@gtf.org>
	 <1045780188.1429.30.camel@localhost.localdomain>
	 <20030220224225.GU9800@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1045781199.1431.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 14:46:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 14:42, Jeff Garzik wrote:
> On Thu, Feb 20, 2003 at 02:29:49PM -0800, Timothy D. Witham wrote:
> > Sorry about getting back on the thread late was off doing boring
> > management stuff.
> > 
> > But this is what PLM/STP does but right now it doesn't bother
> > to send the results to any list.
> > 
> > http://www.osdl.org/projects/26lnxstblztn/results/
> 
> Neat, thanks for posting the link.
> 
> IMO, it would be nice to send results to linux-kernel,
> but with a few restrictions:
> 
> * just a small email, with only key bits of info.
>   URLs would point to more detailed information.
> * a constant URL, which describes what the heck the email is all about
>   (such as your above URL)
> * for now, only bother with "ia32 Default"
> * never email more than once a day... even if the bot gets stuck in a
>   spamming loop, you need to have something in place to throttle emails.
> * only email when state changes:  i.e. PASS->FAIL or FAIL->PASS,
>   never PASS->PASS or FAIL->FAIL. [debateable... some may disagree with
>   me on this one]
> 
  I'm not a big fan of only on transition as sometimes things
get broken but nothing ever gets reported.  But your suggestions
will be taken and implemented.

> Comments?
> 
> 	Jeff
> 
> 
> P.S. The column headers in your report are broken, for example "ia32
> Default" goes to bad link
> http://www.osdl.org/projects/plm/def_ia32_default.html
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

