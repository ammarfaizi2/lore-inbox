Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAOTfb>; Mon, 15 Jan 2001 14:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRAOTfU>; Mon, 15 Jan 2001 14:35:20 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:27142 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129532AbRAOTfN>;
	Mon, 15 Jan 2001 14:35:13 -0500
Date: Mon, 15 Jan 2001 20:35:06 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: MTRR type AMD Duron/intel ?
To: linux-kernel@vger.kernel.org
Message-id: <3A6350EA.884AC527@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent 2.4.0 ( not the final , but close  ) kernel prints this :

mtrr: detected mtrr type: intel

I have an AMD K7 Duron 700 CPU

Is this correct ?

It also reports something like :
PCI chipset unknown : assuming transparent

I have a VIA KT133 chipset

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
