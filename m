Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759339AbWLEVrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339AbWLEVrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbWLEVrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:47:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57922 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759747AbWLEVrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:47:47 -0500
Date: Tue, 5 Dec 2006 22:47:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: -mm merge plans for 2.6.20, scheduler bits
Message-ID: <20061205214703.GA14324@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205211723.GA7169@elte.hu> <20061205125909.E5313@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205125909.E5313@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Tue, Dec 05, 2006 at 10:17:23PM +0100, Ingo Molnar wrote:
> > > sched-decrease-number-of-load-balances.patch
> > 
> > this one goes away as per Ken's observation.
> 
> Not really. Ken posted a cleanup patch on top of the above patch. Ken 
> pointed one more cleanup which I will work on it and send it across in 
> a day.

ok.

	Ingo
