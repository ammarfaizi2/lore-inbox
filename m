Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAYLRD>; Thu, 25 Jan 2001 06:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbRAYLQx>; Thu, 25 Jan 2001 06:16:53 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:26377 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129511AbRAYLQi>; Thu, 25 Jan 2001 06:16:38 -0500
Date: Thu, 25 Jan 2001 12:16:31 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: when is overriding idebus safe?
In-Reply-To: <Pine.LNX.4.10.10101241637550.15294-100000@master.linux-ide.org>
Message-ID: <Pine.HPX.4.10.10101251215520.26695-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Andre Hedrick wrote:

> When the manual for your mainboard states that clock settings for setting
> up your CPU creates a change in the normal idebus=33MHz of any other
> value, then you are probablely safe.  Since all 32-bit PCI busses run at
> 33MHz, as last thought and reported, it should not be needed to change.
> If I recall the idebus=XX primary use was for VLB/ISA/EISA systems, but I
> have been wrong before.

My system bus is overclocked to 40MHz. Should I use idebus=44MHz now or
should I stick with the default? How does the value given affect kernel
behaviour?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
