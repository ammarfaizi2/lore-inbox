Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFAO7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFAO7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFAO7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:59:38 -0400
Received: from [195.23.16.24] ([195.23.16.24]:42899 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261404AbVFAO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:59:29 -0400
Message-ID: <429DCD25.3010800@grupopie.com>
Date: Wed, 01 Jun 2005 15:58:45 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random>
In-Reply-To: <20050601144612.GJ5413@g5.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jun 01, 2005 at 04:32:02PM +0200, Andrea Arcangeli wrote:
> 
>>years of doing that in linux. I'm not a lawyer but you may want to
>>check before investing too much on this for the next 15 years. The
> 
> Here's a link that may be of interest:
> 
> http://www.fsmlabs.com/openpatentlicense.html
> http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=12&f=G&l=50&co1=AND&d=ptxt&s1=5,995,745&OS=5,995,745&RS=5,995,745

Did you read this?

All the claims in the "Claims" section of the patent text start with:

> providing a real time operating system for running real time tasks and components and non-real time tasks; 
> 
> providing a general purpose operating system as one of the non-real time tasks; 

This seems like the RTAI kind of nano-kernel approach and has nothing to 
do with the way the RT-PREEMPT patch works, AFAICS.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
