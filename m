Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965565AbWIRISp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbWIRISp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965564AbWIRISp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:18:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63462 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965565AbWIRISn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:18:43 -0400
Message-ID: <450E563B.503@sgi.com>
Date: Mon, 18 Sep 2006 10:18:03 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <450C3E3A.5050100@opersys.com> <20060916174424.GA8602@elte.hu> <450C3F41.30203@opersys.com>
In-Reply-To: <450C3F41.30203@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Ingo Molnar wrote:
>> yes, location very much matters if someone wants to reproduce the 
>> numbers.
> 
> Was that really the angle? I'll give you the benefit of the doubt.
> But I'm sure you understand the importance of probe placement
> with regards to impact of performance ...

So now you produce a benchmark, then won't allow someone to reproduce
it ..... do we see a pattern here?

Jes

