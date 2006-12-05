Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031360AbWLEVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031360AbWLEVBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031405AbWLEVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:01:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33003 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031375AbWLEVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:01:37 -0500
Date: Tue, 5 Dec 2006 22:00:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205210022.GA4249@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> gtod-exponential-update_wall_time.patch
> 
>  Roman wanted this dropped, and afaik that's unresolved.

please drop this one for now, we'll rework it. It's an optimization, not 
a showstopper must-have component.

	Ingo
