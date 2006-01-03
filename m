Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWACL1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWACL1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWACL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:27:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:35226 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751370AbWACL1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:27:18 -0500
Date: Tue, 3 Jan 2006 12:27:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
Message-ID: <20060103112716.GA2612@elte.hu>
References: <20060103094720.GA16497@elte.hu> <6bffcb0e0601030321h62aab08bi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0601030321h62aab08bi@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi Ingo,
> 
> [1.] One line summary of the problem:
> the same things as in 2.6.15-rc7-rt3, dmesg attached

ok, that's the lost-preemption-check still triggering. Does the system 
otherwise work as expected? The message should be harmless - unless you 
are also seeing other problems.

	Ingo
