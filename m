Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRKSIk2>; Mon, 19 Nov 2001 03:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKSIkJ>; Mon, 19 Nov 2001 03:40:09 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:1800 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S275012AbRKSIj7>;
	Mon, 19 Nov 2001 03:39:59 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111190839.fAJ8dve95358@saturn.cs.uml.edu>
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo Molnar
To: partha@us.ibm.com (Partha Narayanan)
Date: Mon, 19 Nov 2001 03:39:57 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com> from "Partha Narayanan" at Nov 17, 2001 10:58:05 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Partha Narayanan writes:

> The above patch for scheduler cache affinity improvement in 2.4 kernels by
> Ingo Molnar was applied to 2.4.14 kernel;

Just a thought: some processors tell you how many cache lines
have been thrown out. Look in whatever performance monitoring
registers are available.
