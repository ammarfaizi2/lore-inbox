Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKFSg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKFSg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKFSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:36:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45231 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261424AbUKFSg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:36:56 -0500
Message-ID: <418D19BB.8020204@pobox.com>
Date: Sat, 06 Nov 2004 13:36:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata.h undefined types in USB
References: <Pine.GSO.4.44.0411061639270.14682-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0411061639270.14682-100000@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> This is todays BK on a x86:
> 
>   CC [M]  drivers/usb/storage/freecom.o
> In file included from include/linux/hdreg.h:4,
>                  from drivers/usb/storage/freecom.c:32:
> include/linux/ata.h:197: error: parse error before "u32"
> ...
> and so on for tens of lines.

I'll grab this and push upstream ASAP...

	Jeff



