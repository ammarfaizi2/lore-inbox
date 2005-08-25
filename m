Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVHYGa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVHYGa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVHYGa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:30:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52113 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751537AbVHYGa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:30:29 -0400
Date: Thu, 25 Aug 2005 08:31:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
Message-ID: <20050825063110.GA27291@elte.hu>
References: <1124739657.5809.6.camel@localhost.localdomain> <1124739895.5809.11.camel@localhost.localdomain> <1124749192.17515.16.camel@dhcp153.mvista.com> <1124756775.5350.14.camel@localhost.localdomain> <1124758291.9158.17.camel@dhcp153.mvista.com> <1124760725.5350.47.camel@localhost.localdomain> <1124768282.5350.69.camel@localhost.localdomain> <1124908080.5604.22.camel@localhost.localdomain> <1124917003.5711.8.camel@localhost.localdomain> <1124932391.5527.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124932391.5527.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> So, Ingo, what do you think of the changes so far?  Do you feel that 
> it is stable enough to send you an actual real patch. That way we can 
> work together in cleaning it up and get all the other kinks out.

yeah, please send me a patch against 2.6.13-rc7-rt1 if possible.

	Ingo
