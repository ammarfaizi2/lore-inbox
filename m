Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313802AbSDIC7N>; Mon, 8 Apr 2002 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313810AbSDIC7M>; Mon, 8 Apr 2002 22:59:12 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:13325 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S313802AbSDIC7K>; Mon, 8 Apr 2002 22:59:10 -0400
Message-Id: <5.1.0.14.2.20020409103623.025e5178@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 09 Apr 2002 10:59:07 +0800
To: linux-kernel@vger.kernel.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: SMP problem with 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I am having a problem with a new dual box, its a dual athlon 1900+,
in a Asus A7M-266-D. When I try using MPS 1.4 the kernel gets upto
printing out CPU1:<T0:...  but no further.

When I switch to MPS 1.1 everything works correctly?

After doing some research I found that by adding the noapic and apm=off
kernel parameters everything started to work with 1.4.

Is this normal? Is it better to run with 1.1 or 1.4 and noapic?

If you need more info please ask :)

Thanks
Dave





/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

