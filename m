Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132209AbRAJIje>; Wed, 10 Jan 2001 03:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRAJIjY>; Wed, 10 Jan 2001 03:39:24 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:23437 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132453AbRAJIjI>; Wed, 10 Jan 2001 03:39:08 -0500
Message-ID: <3A5C2142.C119CE7C@uow.edu.au>
Date: Wed, 10 Jan 2001 19:45:54 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stéphane Borel <stef@via.ecp.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM Netfinity with 2.4.0
In-Reply-To: <20010110024744.A26255@via.ecp.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stéphane Borel" wrote:
> 
> We have two Netfinity (7100 with 4 Xeon and 4500R with two PIII) and we
> have noticed a weird behaviour with kernel 2.4.0 test and final.
> 
> *On the 7100, the final kernel can't detect two pci card (3C980 and
> ForeRunnerLE.

Can it detect other PCI devices?

The output from `dmesg' and `lspci -vv' would be interesting.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
