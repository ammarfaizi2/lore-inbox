Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGVDKa>; Sun, 21 Jul 2002 23:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSGVDKa>; Sun, 21 Jul 2002 23:10:30 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:61189 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S315539AbSGVDK3>; Sun, 21 Jul 2002 23:10:29 -0400
Message-Id: <5.1.1.6.0.20020722111310.0356ed70@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 22 Jul 2002 11:13:14 +0800
To: linux-kernel@vger.kernel.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: Re: SMP Problem with 2.4.19-rc2 on Asus A7M266-D
In-Reply-To: <5.1.1.6.0.20020719121809.01d15d88@pop.cs.curtin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK I just put on 2.4.19-rc3 and it works fine, so maybe its something in
the ac patch?
D.


At 12:26 PM 19/07/2002 +0800, David Shirley wrote:
>Hi Guys,
>
>I was running 2.4.18 with an Asus A7M266-D Board with Athlon 2000 MP's fine,
>I decided to try out 2.4.19-rc2-ac2 and now the machine doesn't even boot.
>
>With no kernel options (in grub) it gets upto "ENABLING IO-APIC IRQ's" and 
>a little
>bit further then it hangs and prints out "APIC error on CPU0: 00(08)"
>
>If i put in noapic in grub it does exactly the same thing but prints out 
>the above lots and
>lots in quick succession and with CPU1 not 0.
>
>Btw: It does the same thing with MPS1.4 rather than 1.1
>
>Anyone?
>
>Cheers
>Dave
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

