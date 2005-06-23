Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVFWD5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFWD5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVFWD5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:57:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52945 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261935AbVFWD5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:57:30 -0400
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <42BA1850.4060505@opersys.com>
References: <1119287612.6863.1.camel@localhost>
	 <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com>
	 <20050622192927.GA13817@nietzsche.lynx.com>
	 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>
	 <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
	 <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>
	 <20050623013451.GA14137@elte.hu>  <42BA1850.4060505@opersys.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 23:57:21 -0400
Message-Id: <1119499041.25270.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 22:02 -0400, Karim Yaghmour wrote:
> OK, please recheck the webpage, I've now added a warning specifically
> to the effect that the numbers need to be rerun. Hopefully this clears
> things up. 

Are you talking about the first run where you left all those expensive
PREEMPT_RT debug options enabled?

IMHO those numbers should be taken down, they're completely meaningless.

Lee

