Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131058AbRAEQ7P>; Fri, 5 Jan 2001 11:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbRAEQ7F>; Fri, 5 Jan 2001 11:59:05 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:26753 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131090AbRAEQ6u>; Fri, 5 Jan 2001 11:58:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010105085514.A12902@bluemug.com> 
In-Reply-To: <20010105085514.A12902@bluemug.com>  <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com> <E14EEr4-000697-00@the-village.bc.nu> 
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Lang <david.lang@digitalinsight.com>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 16:57:42 +0000
Message-ID: <11503.978713862@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


miket@bluemug.com said:
>  Many newer cell phones, even low spec ones, will have a software
> power switch (usually with a hardware override after about 5 seconds
> of continuous press).  There are many other concessions that need to
> be made to power efficiency, like the ability to toggle power to even
> very minor peripherals and chips (not only each CPU and DSP, but the
> bus controllers and UARTs connecting things together).  These things
> sell in the millions, so their designers can easily budget the custom
> logic.

Even if it only costs pennies - why on earth would someone want to add 
logic to a board when they could just fix the software?

It soon adds up when you ship a million units.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
