Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQLOPtY>; Fri, 15 Dec 2000 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLOPtO>; Fri, 15 Dec 2000 10:49:14 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:17539 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129449AbQLOPsy>;
	Fri, 15 Dec 2000 10:48:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <802569B6.0053B0D6.00@d06mta06.portsmouth.uk.ibm.com> 
In-Reply-To: <802569B6.0053B0D6.00@d06mta06.portsmouth.uk.ibm.com> 
To: richardj_moore@uk.ibm.com
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Question about RTC interrupts on i386 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Dec 2000 15:17:03 +0000
Message-ID: <1516.976893423@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


richardj_moore@uk.ibm.com said:
> I'm not sure there's any particular advantage to the TOD clock on IRQ 8. 

It means that IRQ0 is free to be used for the PC speaker driver :)

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
