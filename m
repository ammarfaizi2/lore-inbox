Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWIRDd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWIRDd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWIRDd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:33:26 -0400
Received: from opersys.com ([64.40.108.71]:4625 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751305AbWIRDdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:33:25 -0400
Message-ID: <450E1860.8010301@opersys.com>
Date: Sun, 17 Sep 2006 23:54:08 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <450E053B.1070908@opersys.com> <20060918025722.GA11894@elte.hu>
In-Reply-To: <20060918025722.GA11894@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> Plese dont put words into my mouth. No, i dont assume they are mutually 
> exclusive, did i ever claim that? But i very much still claim what my 
> point was, and which point you disputed (at the same time also insulting 
> me): that even if hell freezes over, a static tracer wont be able to 
> extract 'x' from the MARK(event, a) markup. You accused me unfairly, you 
> insulted me and i defended my point. In case you forgot, here again is 
> the incident, in its entirety, where i make this point and you falsely 
> dispute it:

Is this a recursive thread? Because if it is, I might as well point to
my follow-up to your answer, and that's not going to get us anywhere.

By no stretch of the english language did I insult you. This is a
convenient fabrication which *I* could take as an insult. Calling
into question a person's expertise on a given topic is by no
means unheard of in the scientific discourse if said person
insists on pushing an agenda using said "expertise" as the
founding basis. So no, the emperor has no cloths in this case:
you have de-facto proven your own expertise in this field is
but very limited. Historically, and maybe you're an exception
to this, individuals in the scientific community that took insult
when their "expertise" was questioned, as I did in the snippet
you so conveniently highlight, were usually wrong. Real experts
don't need status to prove their point: they use facts.

The fact that X cannot be extracted from a statically defined
set containing (K,P,F,Y,Z) is high school mathematics at best.
Your insistence on such a theoretical example is, for me, but
further proof of your actual lack of *practical* experience.
Because those with actual *practical* experience, have presented
us with *facts* and empirical *results*, both highly prized in
the scientific discourse, that in-real-life, contrary to
Ingo's strawman constructions, users would benefit from having
access to events collected using a variety of *mechanisms*.

So, yes Ingo, you "wont be able to  extract 'x' from the
MARK(event, a) markup" using just a "static" tracer. What such
emphasis on this statement on your part and utter refusal
to respond to very solidly constructed arguments on my part
while instead choosing to emphasize "moral" tort entails,
however, is an entirely separate issue altogether.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
