Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUJBRUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUJBRUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUJBRRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:17:01 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:10213 "EHLO
	mwinf0206.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267433AbUJBRQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:16:07 -0400
Message-ID: <415EE250.4010108@setibzh.com>
Date: Sat, 02 Oct 2004 19:16:00 +0200
From: Beber <beber@setibzh.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DMA timeout error
References: <cjmk3s$gjs$1@sea.gmane.org>
In-Reply-To: <cjmk3s$gjs$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add pci=noapic to your boot option
;)

Adam Sherman wrote:

> I have a VIA M6000 board with an ATA CompactFlash adaptor containing a
> 512MB SanDisk card.
>
> I get the following error during boot:
>
> hdb: dma_timer_expiry: dma status == 0x41
> hdb: DMA timeout error
> hdb: dma timeout error: status=0x58 { DriveReady SeekComplete 
> DataRequest }
>
> hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>
> hdb: drive not ready for command
> hdb: dma_timer_expiry: dma status == 0x41
> hdb: DMA timeout error
> hdb: dma timeout error: status=0x58 { DriveReady SeekComplete 
> DataRequest }
>
> hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>
> hdb: drive not ready for command
>
>
> Any ideas?
>
> Thanks,
>
> A.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
/* Beber : beber (AT) setibzh (DOT) com
* https://guybrush.ath.cx
* Using Mozilla Thunderbird on Gentoo Linux
* Rachel @ friends.paris
*/


