Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVKUVdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVKUVdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKUVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:33:41 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:62186 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1750716AbVKUVdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:33:41 -0500
Subject: Re: 2.6.14-rt13
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051115090827.GA20411@elte.hu>
References: <20051115090827.GA20411@elte.hu>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 13:32:08 -0800
Message-Id: <1132608728.4805.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 10:08 +0100, Ingo Molnar wrote:
> i have released the 2.6.14-rt13 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of fixes in this release affecting all supported architectures, all 
> across the board. Big MIPS update from John Cooper.

Can someone tell me if 2.6.14-rt13 is supposed to be fixed re: the
problems I was having with random screensaver triggering and keyboard
repeats?

It is apparently not fixed. 

I just had a short burst of key repeats and saw one random screen blank.
Right now everything seems normal but I was not allucinating :-)

-- Fernando


