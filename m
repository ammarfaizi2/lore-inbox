Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSAZW6C>; Sat, 26 Jan 2002 17:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSAZW5w>; Sat, 26 Jan 2002 17:57:52 -0500
Received: from [208.179.59.195] ([208.179.59.195]:28493 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S287212AbSAZW5g>; Sat, 26 Jan 2002 17:57:36 -0500
Message-ID: <3C53346B.9020805@blue-labs.org>
Date: Sat, 26 Jan 2002 17:57:47 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: 2.5.2-dj5 linking error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/scsidrv.o: In function `BusLogic_InterruptHandler':
drivers/scsi/scsidrv.o(.text+0x10d65): undefined reference to 
`scsi_mark_host_reset'

got a quick fix?

-d


