Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTK3Bve (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 20:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTK3Bvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 20:51:33 -0500
Received: from mail.gmx.de ([213.165.64.20]:6633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264592AbTK3Bvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 20:51:32 -0500
X-Authenticated: #4512188
Message-ID: <3FC94D20.6020007@gmx.de>
Date: Sun, 30 Nov 2003 02:51:28 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: Julien Oster <frodoid@frodoid.org>, linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de>	 <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org> <1070125634.28187.11.camel@athlonxp.bradney.info>
In-Reply-To: <1070125634.28187.11.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:
>>I can't find the Silicon Image driver under
>>
>>"SCSI low-level drivers" -> "Serial ATA (SATA) support"
>>
>>under 2.6.0-test11. Just the following are there:
>>
>>ServerWorks Frodo
>>Intel PIIX/ICH
>>Promisa SATA
>>VIA SATA
>>
> 
> 
> Try under ATA/ATAPI/MFM/RLL support
> 
> Silicon Image Chipset Support
> CONFIG_BLK_DEV_SIIMAGE:                                                                           This driver adds PIO/(U)DMA support for the SI CMD680 and SII 3112 (Serial ATA) chips.

No, that is the ide driver that sucks big time.

Prakash

