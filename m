Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSF2Ie0>; Sat, 29 Jun 2002 04:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSF2IeZ>; Sat, 29 Jun 2002 04:34:25 -0400
Received: from lapd.cj.edu.ro ([193.231.142.101]:33940 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S293203AbSF2IeY>;
	Sat, 29 Jun 2002 04:34:24 -0400
Date: Sat, 29 Jun 2002 11:36:44 +0300 (EEST)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: Axel Siebenwirth <axel@hh59.org>
cc: Lech Szychowski <lech.szychowski@pse.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: IRQ sharing problem - 2.4.18 kernel
In-Reply-To: <20020628142628.GA15140@neon.hh59.org>
Message-ID: <Pine.LNX.4.43L0.0206291134430.6814-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > No. I have 2 Intel NICs and 3 RTL 8139 NICs ... the problems is not from 
> > the driver.
> Hmm. Not sure about that. I had same problems with my RTL 8139. Build a new
> kernel with CONFIG_8139TOO_PIO set. That's what solved it with my machine.


It dosen't works. If you have some experience in usage of pirq option 
please tell me how to use tha option.

Thanx a lot for the answers,
Cosmin

