Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRDEBce>; Wed, 4 Apr 2001 21:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDEBc0>; Wed, 4 Apr 2001 21:32:26 -0400
Received: from VM.NMU.EDU ([198.110.200.34]:38615 "HELO VM.NMU.EDU")
	by vger.kernel.org with SMTP id <S132545AbRDEBb4>;
	Wed, 4 Apr 2001 21:31:56 -0400
Message-Id: <5.0.0.25.2.20010404211904.009d3eb0@pop.mail.nmu.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Wed, 04 Apr 2001 21:30:51 -0400
To: linux-kernel@vger.kernel.org
From: "Carey B. Stortz" <castortz@nmu.edu>
Subject: Signal Handling Performance?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing a research project on Linux kernel performance starting with the
2.0.1 kernel through the 2.4.0 kernel. I ran across something very
interesting when running LMBench and reviewing the results. The performance
of Signal Handling has decreased while every other area has either stayed
the same or had a performance increase. A general decrease started around
kernel 2.1.32, then performance drastically fell at kernel 2.3.20. There is
an Excel graph which shows the trend at:

http://euclid.nmu.edu/~benchmark/Carey/signalhandling.gif

I was wondering if anybody had any ideas why this is happening, and what
happened in kernel 2.3.20 to cause such a decrease in performance?

Thanks for your time
Carey Stortz

