Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129592AbRBFXwd>; Tue, 6 Feb 2001 18:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRBFXwX>; Tue, 6 Feb 2001 18:52:23 -0500
Received: from rak.isternet.sk ([195.72.0.6]:23825 "EHLO rak.isternet.sk")
	by vger.kernel.org with ESMTP id <S129592AbRBFXwG>;
	Tue, 6 Feb 2001 18:52:06 -0500
Date: Wed, 7 Feb 2001 00:52:04 +0100
From: Juraj Bednar <juraj@bednar.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: smp_num_cpus redefined? (compiling 2.2.18 for non-SMP?)
Message-ID: <20010207005203.A19812@rak.isternet.sk>
Reply-To: Juraj Bednar <juraj@bednar.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


  the same for vanilla 2.4.1 and 2.4.1ac3. Everything works ok until I turn off SMP
support (which is required to make it possible to turn off the machine using APM, since
ACPI is completely broken in 2.4.1 for me).


             Juraj.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
