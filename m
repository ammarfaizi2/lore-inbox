Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbQKUReL>; Tue, 21 Nov 2000 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQKUReB>; Tue, 21 Nov 2000 12:34:01 -0500
Received: from isolaweb.it ([213.82.132.2]:40202 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S129735AbQKURdv>;
	Tue, 21 Nov 2000 12:33:51 -0500
Message-Id: <4.3.2.7.2.20001121174403.00d3e450@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 21 Nov 2000 17:58:58 +0100
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Ext2 & Performances
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I need to know if there are some differences, in performances, between
a ext2 filesystem in a 10Gb partition and another that reside in a 130Gb,
each one have 4Kb block size.

I'm configuring a Compaq ML350 2x800PIII, 1Gb RAM, 5x36Gb UWS3 RAID 5
with Smart Array 4300, as database SQL server. So I need to chose between a 
single
partition of 130Gb or multiple small partitions, depending by the performances.

Thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
