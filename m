Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUGJBDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUGJBDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUGJBDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:03:36 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:12188 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266063AbUGJBDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:03:33 -0400
Date: Sat, 10 Jul 2004 02:02:02 +0100
From: Dave Jones <davej@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710010202.GA6386@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710005208.GW20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710005208.GW20947@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 02:52:08AM +0200, Andrea Arcangeli wrote:
 > On Sat, Jul 10, 2004 at 01:50:17AM +0200, Andrea Arcangeli wrote:
 > > agreed. might_sleep() just like BUG() can be defined to noop.
 > 
 > BTW, this reminded me a related topic that I can't recall being ever
 > mentioned on l-k: 

google for 'BUG_ON side effects'. It's come up a number of times 8-)
Doesn't mean it isn't worth repeating however.

		Dave

