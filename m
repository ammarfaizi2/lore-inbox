Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGJWr>; Wed, 7 Feb 2001 04:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbRBGJWh>; Wed, 7 Feb 2001 04:22:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129028AbRBGJWT>; Wed, 7 Feb 2001 04:22:19 -0500
Subject: Re: PCI-SCI Drivers v1.1-7 released
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 7 Feb 2001 09:22:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010206190624.C23960@vger.timpanogas.org> from "Jeff V. Merkey" at Feb 06, 2001 07:06:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QQoH-0008CH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
> 7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
> from the gcc 2.91 compiled version on the identical SAME 2.4.1 
> source tree. 

30% is too big to be caused by a compiler. Way too big.I suggest you review
your code.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
