Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUAJQGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUAJQGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:06:51 -0500
Received: from [216.127.68.117] ([216.127.68.117]:62865 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S265246AbUAJQGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:06:47 -0500
Message-ID: <4000230D.109@meerkatsoft.com>
Date: Sun, 11 Jan 2004 01:06:37 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot Set DMA via hdparm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am having problems settng the DMA ( hdparm -d1 /dev/hda ) on a RH9 
2.4.28 Linux machine.
I always get the following error messages:

HDIO_SET_DMA failed: Operatopm mpt @er,otted
using_dma = 0 (off)

The Disk ST3120026A is properly recognized. It appears that the 
motherboard is not supported. ( I am running linux on a Shuttle XPC with 
the ATI Radeon 9100IGP / IXP150 Chipset.

Has anyone an idea how to get this dma setting work ?
Will that chipset be supported in the future ?

Thanks
Alex
* *


