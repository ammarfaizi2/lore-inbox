Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFAPiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFAPiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFAPiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:38:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57159
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261430AbVFAPiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:38:13 -0400
Date: Wed, 1 Jun 2005 17:38:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601153803.GO5413@g5.random>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DD533.6080407@opersys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:33:07AM -0400, Karim Yaghmour wrote:
> in a wider context of all the other statements within that claim, the main
> part being what I quoted earlier.

Ok great, I trust your patent knowledge given your background ;).

It's very reassuring that I was wrong and preempt-rt is not covered by
the patent. Until now I really understood that redefining an hard irq
disable to a soft irq disable was forbidden at large.
