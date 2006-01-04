Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWADUNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWADUNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWADUNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:13:45 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:10041 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751296AbWADUNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:13:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QiqayJsg5IfWB8Tku+AxSFGByunNYGAyTc57teKCFo1R62wDHQlw7edPRKcyUB7aN0V+dAoPr1Qu8k6AtsDR0In5unTnnmGumvkDKLHOnsvolGY3ULtNOlkH42R6vuOW6aC1HFJi9qwfsUcTGyuTNZEPQvBuTabEftiSKEZmawc=
Message-ID: <43BC2C75.70202@gmail.com>
Date: Wed, 04 Jan 2006 22:13:41 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: andyliebman@aol.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Atapi CDROM, SATA OS drive, and 2.6.14+ kernel
References: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com>
In-Reply-To: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andyliebman@aol.com wrote:
> I have an image of a working 2.6.14 system that was installed on an IDE 
> drive. I restored the image to a SATA drive, changed a few lines in 
> /etc/fstab and /etc/lilo.conf so that they refer to /dev/sd* devices 
> instead of /dev/hd* devices.

If all your drives are S/ATA, your CDROM should be the only /dev/hd? device.

if you try 'ls /dev/hd?', doesn't it show anything?

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

