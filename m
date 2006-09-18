Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965571AbWIRIVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbWIRIVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965568AbWIRIVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:21:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37561 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965571AbWIRIVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:21:35 -0400
Message-ID: <450E56ED.5050201@sgi.com>
Date: Mon, 18 Sep 2006 10:21:01 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <450C3A98.4060704@opersys.com>
In-Reply-To: <450C3A98.4060704@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Mathieu Desnoyers wrote:
>> The bottom line is :
>>
>> LTTng impact on the studied phenomenon : 35% slower
>>
>> LTTng+kprobes impact on the studied phenomenon : 73% slower
>>
>> Therefore, I conclude that on this type of high event rate workload, kprobes
>> doubles the tracer impact on the system.
> 
> Amen to that. Hopefully this puts to rest the myth of Mr. Scrub.

If it wasn't because it's so sad, this would be hysterically funny.

Jes


