Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbRGEWk7>; Thu, 5 Jul 2001 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265350AbRGEWku>; Thu, 5 Jul 2001 18:40:50 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:1028 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S265290AbRGEWkc>; Thu, 5 Jul 2001 18:40:32 -0400
Message-Id: <m15IHnE-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <20010705181544.Y17051@athlon.random> "from Andrea Arcangeli at
 Jul 5, 2001 06:15:44 pm"
To: Andrea Arcangeli <andrea@suse.de>
Date: Thu, 5 Jul 2001 17:40:16 -0500 (CDT)
CC: Arjan van de Ven <arjanv@redhat.com>,
        Thibaut Laurent <thibaut@celestix.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli quoted:
> On Thu, Jul 05, 2001 at 11:46:33AM -0400, Arjan van de Ven wrote:
> > On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> > > And the winner is... Andrea. Kudos to you, I've just applied these patches,
> > > recompiled and it seems to work fine.
> > > Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> > > boxen ;)
> > 
> > As Andrea's patches don't actually fix anything Cyrix related it's obvious
> > that they just avoid the real bug instead of fixing it.
> > It's a very useful datapoint though.

Put me in the "it works for me" camp also.  Do we have the definitive answer
as far as what is/was broken?   Thanks, Andrea...

--Bob Tracy
rct@frus.com
