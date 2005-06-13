Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFMUeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFMUeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFMUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:30:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38648 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261303AbVFMU2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:28:35 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: karim@opersys.com
Cc: paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <42ADEC0E.4020907@opersys.com>
References: <20050610223724.GA20853@nietzsche.lynx.com>
	 <20050610225231.GF6564@g5.random>
	 <20050610230836.GD21618@nietzsche.lynx.com>
	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>
	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>
	 <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com>
	 <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>
	 <42ADE334.4030002@opersys.com>
	 <1118693033.2725.21.camel@dhcp153.mvista.com>
	 <42ADEC0E.4020907@opersys.com>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 13 Jun 2005 13:28:15 -0700
Message-Id: <1118694495.2725.32.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 16:26 -0400, Karim Yaghmour wrote:
> Daniel Walker wrote:
> > I think this is mistake. Projects that create separation like this are
> > begging for the community to reject them. I see this as a design for
> > one, instead of design for many mistake. From what I've seen, a project
> > would want to do as much clean integration as possible.
> 
> I understand what you're saying, but based on the feedback
> PREEMPT_RT has gotten up until now, and now outright suggestions
> that the debate is not even relevant to the LKML, I think that
> some people are trying to give those interested a hint: integration
> with mainline code is NOT on the agenda.

I wouldn't work on RT if mainline integration wasn't on the agenda. 

> Some may want to continue trying to force-feed mainstream
> maintainers. I can't stop anyone from trying, that's for sure.
> However, I think what I'm suggesting is a reasonable compromise:
> mainstream maintainers don't need to care about RT on a day-to-
> day basis and the RT folks get to be part of mainline.

There is going to be positive , and negative discussion on this. I think
in the end the maintainers (Linus, and Andrew) don't want "people" to
get a patch or modification from the outside. It's best if the community
is not separated .. If you make a clean integration , and people want
what you are doing, there is no reason for it to be rejected.

Daniel

