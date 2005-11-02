Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVKBNML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVKBNML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVKBNML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:12:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39593 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932699AbVKBNMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:12:10 -0500
Date: Wed, 2 Nov 2005 14:12:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] additional -rt RCU usage fixes
Message-ID: <20051102131229.GB11621@elte.hu>
References: <20051101170153.GA6564@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101170153.GA6564@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> I guess I need to be more careful when creating experimental RCU 
> patches, as people have been copying my mistakes.  Here is a patch to 
> fix some of them in -rt.

thanks, applied - will show up in -rt3. Should be done for -mm too, 
which now includes rcu-signal-handling.patch?

	Ingo
