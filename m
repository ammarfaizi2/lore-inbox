Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTAEN1g>; Sun, 5 Jan 2003 08:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbTAEN1g>; Sun, 5 Jan 2003 08:27:36 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:30474 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S264739AbTAEN1f>;
	Sun, 5 Jan 2003 08:27:35 -0500
Message-ID: <3E183494.9030501@walrond.org>
Date: Sun, 05 Jan 2003 13:35:16 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: menuconfig Bug in 2.5.54
References: <3E156D61.2040105@walrond.org> <3E15EDD4.98FF8EBF@linux-m68k.org>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

I cannot reproduce this myself now. Please disregard.

Andrew

Roman Zippel wrote:
> Hi,
> 
> Andrew Walrond wrote:
> 
> 
>>In the PCI Bus section, setting the pci access method to BIOS or direct
>>does not get saved on exit. It always defaults back to "Any" on next
>>make menuconfig
> 
> 
> Can you send me your .config? I cannot reproduce it here.
> 
> bye, Roman
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


