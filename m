Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136726AbRAHKvV>; Mon, 8 Jan 2001 05:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHKvL>; Mon, 8 Jan 2001 05:51:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:22024 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S136726AbRAHKvB>; Mon, 8 Jan 2001 05:51:01 -0500
Message-ID: <3A599B6D.E9757E5A@idb.hist.no>
Date: Mon, 08 Jan 2001 11:50:21 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: nbreun@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: APIC-ERROR-Messages -
In-Reply-To: <01010611131600.08129@nmb>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Breun wrote:
> 
> Hallo,
> 
> sorry if this is a silly question...
> as far as I understood my smp-board seem not well designed - so I get APIC
> error messages nearly every 1-3 seconds. These mmessages do not help me
> because -so I was told - it is not possible to fix the problem.
> Is it possible to eliminate these error messages. My logfiles grow enormously
> and are "trashed" with these messages...
> 
> I'm running Kernel 2.4.0ac2 successfully  hoping that "sudden death" will not
> come back...

I don't know what board you have, but my abit BP6 improved with more
cooling
(better fans on the cpu's and a fan on another hot chip that only had a 
heatsink before.)  And use thermal grease instead of the cleaner but
inferior 
rubber pads.
  
Lower clock frequency tends to help too, but nobody wants that. ;-)

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
