Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318444AbSGSEXv>; Fri, 19 Jul 2002 00:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318442AbSGSEXv>; Fri, 19 Jul 2002 00:23:51 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:27407 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S318444AbSGSEXv>; Fri, 19 Jul 2002 00:23:51 -0400
Message-Id: <5.1.1.6.0.20020719121809.01d15d88@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 19 Jul 2002 12:26:33 +0800
To: linux-kernel@vger.kernel.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: SMP Problem with 2.4.19-rc2 on Asus A7M266-D
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I was running 2.4.18 with an Asus A7M266-D Board with Athlon 2000 MP's fine,
I decided to try out 2.4.19-rc2-ac2 and now the machine doesn't even boot.

With no kernel options (in grub) it gets upto "ENABLING IO-APIC IRQ's" and 
a little
bit further then it hangs and prints out "APIC error on CPU0: 00(08)"

If i put in noapic in grub it does exactly the same thing but prints out 
the above lots and
lots in quick succession and with CPU1 not 0.

Btw: It does the same thing with MPS1.4 rather than 1.1

Anyone?

Cheers
Dave

