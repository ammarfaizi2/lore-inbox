Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFAPA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFAPA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFAO7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:59:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:49542 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261407AbVFAO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:59:31 -0400
Message-ID: <429DCCB2.3060802@nortel.com>
Date: Wed, 01 Jun 2005 08:56:50 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random>
In-Reply-To: <20050601144612.GJ5413@g5.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=12&f=G&l=50&co1=AND&d=ptxt&s1=5,995,745&OS=5,995,745&RS=5,995,745

I'm not a lawyer, but claim 1 in that document specifically talks about 
having an RTOS that runs a general purpose OS.

Does that limit the rest of the claims to only apply in the context of 
that scenario?

In the case of preempt-RT there is only the one OS involved, so if the 
claims are limited to the case where the general OS runs on top of an 
RTOS, it would seem that the patent does not apply.

Chris


