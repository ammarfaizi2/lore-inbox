Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289925AbSAPMk2>; Wed, 16 Jan 2002 07:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290433AbSAPMkT>; Wed, 16 Jan 2002 07:40:19 -0500
Received: from web13001.mail.yahoo.com ([216.136.174.11]:22181 "HELO
	web13001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290432AbSAPMkJ>; Wed, 16 Jan 2002 07:40:09 -0500
Message-ID: <20020116124008.50778.qmail@web13001.mail.yahoo.com>
Date: Wed, 16 Jan 2002 04:40:08 -0800 (PST)
From: prodyut hazarika <prodyut_hazarika@yahoo.com>
Subject: Interpreting ELF file on a ramdisk (block device)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I get an ELF file on a ramdisk using TFTP. I want to
interpret the ELF file in the ramdisk, and load it
into memory (SDRAM) using the ramdisk as a block
device, but without using any file system.

Is this possible? Any pointers will be greatly
appreciated.

Thanks,
prodyut.

PS: Currently I use CRAMFS to get the ELF file into
ramdisk. Then I load the ELF file into memory using
CRAMFS. I want to get rid of the CRAMFS on top of ELF.





__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
