Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVFWAJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVFWAJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFWAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:07:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47602 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261842AbVFWAG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:06:58 -0400
Date: Wed, 22 Jun 2005 17:05:49 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, <linux-kernel@vger.kernel.org>,
       <paulmck@us.ibm.com>, <andrea@suse.de>, <tglx@linutronix.de>,
       <pmarques@grupopie.com>, <bruce@andrew.cmu.edu>,
       <nickpiggin@yahoo.com.au>, <ak@muc.de>, <sdietrich@mvista.com>,
       <hch@infradead.org>, <akpm@osdl.org>, <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
In-Reply-To: <42B9F673.4040100@opersys.com>
Message-ID: <Pine.LNX.4.44.0506221703030.6783-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Karim Yaghmour wrote:

> To be honest, however, I have a very hard time, as a user, to
> convince myself that I should enable preempt_rt under any but
> the most dire situations given the results I now have in front
> of me. Surely there's more of an argument than "this will cost
> you as much as SMP" for someone deploying UP systems, which
> apparently is the main target of preempt_rt with things like
> audio and embedded systems.

What situation do you consider dire?

I do appreciate the testing that you've done and I hope you do more in the 
future. Remember that PREEMPT_RT is a fast moving object, we need those 
kinds of tests every day .. 


Daniel

