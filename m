Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264923AbRFUHrl>; Thu, 21 Jun 2001 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbRFUHrc>; Thu, 21 Jun 2001 03:47:32 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:7438 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264923AbRFUHrU>;
	Thu, 21 Jun 2001 03:47:20 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106210746.f5L7k0d356118@saturn.cs.uml.edu>
Subject: Re: [OT] Threads, inelegance, and Java
To: landley@webofficenow.com
Date: Thu, 21 Jun 2001 03:45:59 -0400 (EDT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        mharrold@cas.org (Mike Harrold), linux-kernel@vger.kernel.org
In-Reply-To: <01062013535909.00776@localhost.localdomain> from "Rob Landley" at Jun 20, 2001 01:53:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:
> On Wednesday 20 June 2001 15:53, Martin Dalecki wrote:
>> Mike Harrold wrote:

>> super computing, hmm what about some PowerPC CPU variant - they very
>> compettetiv in terms of cost and FPU performance! Transmeta isn't the
>> adequate choice here.
>
> You honestly think you can fit 142 PowerPC processors in a single 1U,
> air cooled?

That 142 would be what, a SHARC DSP system? It sure doesn't look
like Transmeta's Crueso. The best I found was 6 and 8 per 1U:

"RLX has managed to tuck 24 servers into a 3U enclosure" --> 8/U
"WebBunker units can hold 12 processors [in 2U]" --> 6/U

For PowerPC I found 32/U to 40/U, in increments of 9U.
See www.mc.com for an example. The processor gets you 4 (four!)
floating-point fused multiply-add operations per cycle, typically
at 400 MHz. Being optimistic, that's a teraflop in 9U.

> Liquid air cooled, maybe...

Nope, plain old air or conduction.

If you're going to rant about off-topic junk, at least try to
throw in a few useful references so people can check facts and
maybe take advantage of whatever it is you're ranting about.
(yeah, yeah, sorry about the VGA console thing)
