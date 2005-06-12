Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVFLGkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVFLGkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVFLGgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:36:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26306 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261894AbVFLGfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:35:15 -0400
Date: Sun, 12 Jun 2005 08:23:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050612062350.GB4554@elte.hu>
References: <1118214519.4759.17.camel@dhcp153.mvista.com> <20050611165115.GA1012@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611165115.GA1012@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> folks, can you please take this RT stuff of lkml?  And with that I
> don't mean the highlevel discussions what makes sense, but specific
> patches that aren't related to anything near mainline. [...]

this is a misconception - there's been a few dozen patches steadily 
trickling into mainline that were all started in the PREEMPT_RT 
patchset, so this "RT stuff", both the generic arguments and the details 
are very much relevant. I wouldnt be doing it if it wasnt relevant to 
the mainline kernel. The discussions are well concentrated into 2-3 
subjects so you can plonk those threads if you are not interested.

	Ingo
