Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFMEkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFMEkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFMEkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:40:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53127 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261348AbVFMEke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:40:34 -0400
Subject: [RT] Re: [PATCH] local_irq_disable removal
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: sdietrich@mvista.com, linux-kernel@vger.kernel.org,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050612092856.GB1206@infradead.org>
References: <1118214519.4759.17.camel@dhcp153.mvista.com>
	 <20050611165115.GA1012@infradead.org> <20050612062350.GB4554@elte.hu>
	 <20050612092856.GB1206@infradead.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 13 Jun 2005 00:39:56 -0400
Message-Id: <1118637596.29495.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 10:28 +0100, Christoph Hellwig wrote:
> On Sun, Jun 12, 2005 at 08:23:50AM +0200, Ingo Molnar wrote:
> 
> Then send patches when you think they're ready.  Everything directly
> related to PREEPT_RT except the highlevel discussion is defintly offotpic.
> Just create your preempt-rt mailinglist and get interested parties there,
> lkml is for _general_ kernel discussion - even most subsystems that are
> in mainline have their own lists.

Actually Ingo, I think it might be a good time to create a RT list. I'm
much more interested in this topic than the average stuff that is on the
LKML.  The reason I'm more for setting up a mailing list, is that I keep
missing stuff that is related to your patch because there's no common
subject line. For instance, I missed the first 4 messages in this thread
since it didn't have anything about RT in the subject.  If there wasn't
a fifth message, I would never have seen the previous messages.

If anything, please have RT in the Subject.

Thank you,

-- Steve


