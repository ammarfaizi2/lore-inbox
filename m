Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266993AbSLQTaZ>; Tue, 17 Dec 2002 14:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLQTaZ>; Tue, 17 Dec 2002 14:30:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26297 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266993AbSLQTaR>;
	Tue, 17 Dec 2002 14:30:17 -0500
Date: Tue, 17 Dec 2002 11:31:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52-mjb1 (scalability / NUMA patchset)
Message-ID: <162390000.1040153466@flay>
In-Reply-To: <20021217174958.GY2690@holomorphy.com>
References: <19270000.1038270642@flay> <134580000.1039414279@titus> <32230000.1039502522@titus> <568990000.1040112629@titus> <20021217174958.GY2690@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The patchset contains mainly scalability and NUMA stuff, and
>> anything else that stops things from irritating me. It's meant
>> to be pretty stable, not so much a testing ground for new stuff.
>> I'd be very interested in feedback from other people running
>> large SMP or NUMA boxes.
>> http://www.aracnet.com/~fletch/linux/2.5.52/patch-2.5.52-mjb1.bz2
> 
> pfn_to_nid() got lots of icache misses. Try using a macro.

How much difference does this make?

M.

