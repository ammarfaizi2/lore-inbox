Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVFLJbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVFLJbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFLJae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:30:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261923AbVFLJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:28:57 -0400
Date: Sun, 12 Jun 2005 10:28:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050612092856.GB1206@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
	linux-kernel@vger.kernel.org, sdietrich@mvista.com
References: <1118214519.4759.17.camel@dhcp153.mvista.com> <20050611165115.GA1012@infradead.org> <20050612062350.GB4554@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612062350.GB4554@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 08:23:50AM +0200, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > folks, can you please take this RT stuff of lkml?  And with that I
> > don't mean the highlevel discussions what makes sense, but specific
> > patches that aren't related to anything near mainline. [...]
> 
> this is a misconception - there's been a few dozen patches steadily 
> trickling into mainline that were all started in the PREEMPT_RT 
> patchset, so this "RT stuff", both the generic arguments and the details 
> are very much relevant. I wouldnt be doing it if it wasnt relevant to 
> the mainline kernel. The discussions are well concentrated into 2-3 
> subjects so you can plonk those threads if you are not interested.

Then send patches when you think they're ready.  Everything directly
related to PREEPT_RT except the highlevel discussion is defintly offotpic.
Just create your preempt-rt mailinglist and get interested parties there,
lkml is for _general_ kernel discussion - even most subsystems that are
in mainline have their own lists.

