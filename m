Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWBVHxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWBVHxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWBVHxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:53:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18599 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932245AbWBVHx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:53:29 -0500
Date: Wed, 22 Feb 2006 08:51:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
Message-ID: <20060222075144.GA18268@elte.hu>
References: <20060221155548.GA30146@elte.hu> <43FB3E0C.8030901@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB3E0C.8030901@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Also would you apply the attached patch to fix the RTC_HISTOGRAM 
> Kconfig option. In it's current state "tristate" it allows building as 
> a module, which of course doesn't work.

thanks, applied - should show up in -rt18.

	Ingo
