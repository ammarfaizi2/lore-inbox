Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277861AbRKVMSk>; Thu, 22 Nov 2001 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRKVMSe>; Thu, 22 Nov 2001 07:18:34 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:24848 "HELO
	mail.et6.tu-harburg.de") by vger.kernel.org with SMTP
	id <S277861AbRKVMSU>; Thu, 22 Nov 2001 07:18:20 -0500
Message-ID: <3BFCED0B.5113@tu-harburg.de>
Date: Thu, 22 Nov 2001 13:18:19 +0100
From: Thomas Mueller <th.mueller@tu-harburg.de>
Organization: TUHH
X-Mailer: Mozilla 3.01Gold (X11; I; HP-UX B.10.20 9000/712)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic with promise sx6000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've been stupid enough to buy one of those Promise SX6000 RAID
controllers, because there was 'some kind of Linux support' for it.

Now I've got the problem that with several kernel versions I have tried
out (2.4.13-ac8, 2.4.14, 2.4.15-pre7) every time I start the i2o_block
module, I receive a kernel panic based on an interrupt handler problem.

Does any one have any suggestions how to get out of that ??

Thanks

Thomas
-- 
...................................................
:  Thomas Mueller                                 :
:  Technische Universitaet Hamburg-Harburg        :
:  Kommunikationsnetze                            :
:  FSP 4-06                                       :
:                                                 :
:  Denickestrasse 17                              :
:  D-21071 Hamburg                                :
:  Germany                                        :
:  ---------------------------------------------  :
:  Tel. +49-40-42878-3939                         :
:  Fax  +49-40-42878-2941                         :
:                                                 :
:  e-mail:  Th.Mueller@TU-Harburg.de              :
:.................................................:
