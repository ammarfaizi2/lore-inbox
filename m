Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbTBTWcZ>; Thu, 20 Feb 2003 17:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbTBTWcZ>; Thu, 20 Feb 2003 17:32:25 -0500
Received: from havoc.daloft.com ([64.213.145.173]:20125 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265680AbTBTWcY>;
	Thu, 20 Feb 2003 17:32:24 -0500
Date: Thu, 20 Feb 2003 17:42:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Timothy D. Witham" <wookie@osdl.org>
Cc: Paul Larson <plars@linuxtestproject.org>,
       John Bradford <john@grabjohn.com>, davej@codemonkey.org.uk,
       edesio@ieee.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030220224225.GU9800@gtf.org>
References: <200302131823.h1DINeZh016257@darkstar.example.net> <1045170999.28493.57.camel@plars> <20030213213850.GA22037@gtf.org> <1045780188.1429.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045780188.1429.30.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 02:29:49PM -0800, Timothy D. Witham wrote:
> Sorry about getting back on the thread late was off doing boring
> management stuff.
> 
> But this is what PLM/STP does but right now it doesn't bother
> to send the results to any list.
> 
> http://www.osdl.org/projects/26lnxstblztn/results/

Neat, thanks for posting the link.

IMO, it would be nice to send results to linux-kernel,
but with a few restrictions:

* just a small email, with only key bits of info.
  URLs would point to more detailed information.
* a constant URL, which describes what the heck the email is all about
  (such as your above URL)
* for now, only bother with "ia32 Default"
* never email more than once a day... even if the bot gets stuck in a
  spamming loop, you need to have something in place to throttle emails.
* only email when state changes:  i.e. PASS->FAIL or FAIL->PASS,
  never PASS->PASS or FAIL->FAIL. [debateable... some may disagree with
  me on this one]

Comments?

	Jeff


P.S. The column headers in your report are broken, for example "ia32
Default" goes to bad link
http://www.osdl.org/projects/plm/def_ia32_default.html
