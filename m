Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313780AbSDHW7c>; Mon, 8 Apr 2002 18:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313782AbSDHW7b>; Mon, 8 Apr 2002 18:59:31 -0400
Received: from web13207.mail.yahoo.com ([216.136.174.192]:64011 "HELO
	web13207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313780AbSDHW7a>; Mon, 8 Apr 2002 18:59:30 -0400
Message-ID: <20020408225930.31178.qmail@web13207.mail.yahoo.com>
Date: Mon, 8 Apr 2002 15:59:30 -0700 (PDT)
From: joyhaa <joyhaa@yahoo.com>
Subject: kernel instruction level tracing
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020408182923.D2047@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm trying to analyze netfiltering and routing
workload inside the kernel for PowerPC(a typical
kernel 'application', and I can not figure out how to
do the workload analysis in use space for them), is
there a way to trace all the instruction flow(e.g. a
packet coming-in--> going-out) so I can use the result
to further analyze things like cache hit/miss,
latency,drop rate,etc? I'd like to collect the raw
instruction flow in simulation state(non realtime).

LTT(Linux Trace Toolkit) is a good tool, but I want
more detailing tracing info. I tried UML, it doesn't
work well on PowerPC so far.

Is it possible at all?

Thanks


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
