Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbQKGKpj>; Tue, 7 Nov 2000 05:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbQKGKp3>; Tue, 7 Nov 2000 05:45:29 -0500
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:59283 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S129331AbQKGKpN>; Tue, 7 Nov 2000 05:45:13 -0500
Message-Id: <4.3.2.7.2.20001107104110.00e0f530@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Nov 2000 10:44:11 +0000
To: linux-kernel@vger.kernel.org
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: ne2k/wd3018 driver
In-Reply-To: <39CC1197.18D31C88@kalifornia.com>
In-Reply-To: <E13ceNa-00077t-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Does anyone know why a Linux ethernet driver might appear to be up & 
working (that is, no errors, ifconfig says UP, etc), and the board has a 
link light on it, but the hub link light is not on and no packets are 
transmitted or received? rmmod/insmod of the driver doesn't help.

I have an ne2k/ISA Atlantic card that is doing this in either wd or ne mode 
with a 2.2.14 kernel, and can't get it running... help!

Ruth
-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
