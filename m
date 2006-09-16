Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWIPRyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWIPRyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWIPRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:54:47 -0400
Received: from opersys.com ([64.40.108.71]:26387 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S964862AbWIPRyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:54:46 -0400
Message-ID: <450C3F41.30203@opersys.com>
Date: Sat, 16 Sep 2006 14:15:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <450C3E3A.5050100@opersys.com> <20060916174424.GA8602@elte.hu>
In-Reply-To: <20060916174424.GA8602@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> yes, location very much matters if someone wants to reproduce the 
> numbers.

Was that really the angle? I'll give you the benefit of the doubt.
But I'm sure you understand the importance of probe placement
with regards to impact of performance ...

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
