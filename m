Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSAMTxO>; Sun, 13 Jan 2002 14:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSAMTxF>; Sun, 13 Jan 2002 14:53:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36881 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288050AbSAMTws>; Sun, 13 Jan 2002 14:52:48 -0500
Message-ID: <3C41E415.9D3DA253@zip.com.au>
Date: Sun, 13 Jan 2002 11:46:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: jogi@planetzork.ping.de, Ed Sweetman <ed.sweetman@wmich.edu>,
        Andrea Arcangeli <andrea@suse.de>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113184249.A15955@planetzork.spacenet>,
		<E16P0vl-0007Tu-00@the-village.bc.nu>
		<1010781207.819.27.camel@phantasy>
		<20020112121315.B1482@inspiron.school.suse.de>
		<20020112160714.A10847@planetzork.spacenet>
		<20020112095209.A5735@hq.fsmlabs.com>
		<20020112180016.T1482@inspiron.school.suse.de>
		<005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> 
		<20020113184249.A15955@planetzork.spacenet> <1010946178.11848.14.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Again, preempt seems to reign supreme.  Where is all the information
> correlating preempt is inferior?  To be fair, however, we should bench a
> mini-ll+s test.

I can't say that I have ever seen any significant change in throughput
of anything with any of this stuff.

Benchmarks are well and good, but until we have a solid explanation for
the throughput changes which people are seeing, it's risky to claim
that there is a general benefit.

-
