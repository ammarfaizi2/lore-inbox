Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269902AbUJHMZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269902AbUJHMZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269904AbUJHMZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:25:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61905 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269902AbUJHMZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:25:37 -0400
Date: Fri, 8 Oct 2004 14:27:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       "jmerkey@comcast.net" <jmerkey@comcast.net>, jonathan@jonmasters.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone
Message-ID: <20041008122703.GA15604@elte.hu>
References: <100120041740.9915.415D967600014EC2000026BB2200758942970A059D0A0306@comcast.net> <35fb2e590410011509712b7d1@mail.gmail.com> <415DD1ED.6030101@drdos.com> <1096738439.25290.13.camel@localhost.localdomain> <41659748.9090906@drdos.com> <8B592DC4-18A9-11D9-ABEB-000393ACC76E@mac.com> <4165B265.2050506@drdos.com> <8550FDB8-18AC-11D9-ABEB-000393ACC76E@mac.com> <4165B53F.2060707@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4165B53F.2060707@drdos.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-0.825, required 5.9,
	BAYES_01 -1.52, US_DOLLARS_3 0.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff V. Merkey <jmerkey@drdos.com> wrote:

> In business, counter negotiation is allowed. We will pay $50,000.00 in
> cold, hard cash to be allowed to snapshot a single 2.<even number>
> release that allows GPL conversion to a BSD style license. This offer
> is real and we are ready to write a check today.

all the politics aside, the Linux 2.6 kernel, if developed from scratch
as commercial software, takes at least this much effort under the
default COCOMO model:

 Total Physical Source Lines of Code (SLOC)                = 4,287,449
 Development Effort Estimate, Person-Years (Person-Months) = 1,302.68 (15,632.20) (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
 Schedule Estimate, Years (Months)                         = 8.17 (98.10)
  (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
 Estimated Average Number of Developers (Effort/Schedule)  = 159.35
 Total Estimated Cost to Develop                           = $ 175,974,824
  (average salary = $56,286/year, overhead = 2.40).
 SLOCCount is Open Source Software/Free Software, licensed under the FSF GPL.
 Please credit this data as "generated using David A. Wheeler's 'SLOCCount'."

and you want an unlimited license for $0.05m? What is this, the latest
variant of the Nigerian/419 scam?

	Ingo
