Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUBXA7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbUBXA7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:59:52 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:16905 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S262116AbUBXA7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:59:50 -0500
Message-ID: <403AA230.3080500@snapgear.com>
Date: Tue, 24 Feb 2004 11:00:32 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: uClinux development list <uclinux-dev@uclinux.org>
CC: "Hyok S. Choi" <hyok.choi@samsung.com>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [uClinux-dev] Re: the first port of uClinux/ARM for 2.6 kernel
 (armnommu architecture)
References: <009501c3f1ce$13fc88a0$1327dba8@dmsst.net> <20040221212739.GA302@elf.ucw.cz>
In-Reply-To: <20040221212739.GA302@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Pavel Machek wrote:
>> I'm reporting of the first port of new architecture(armnommu) for 2.6
>>kernel is done.
>>
>> I planning the patch against recent kernel version will be announced in
>>this month, after some test and addition of 1~2 more chips. The current
>>port include support of only one (Samsung S5C7375 SoC) for test.
>  
> How common are arms without mmu?

There is quite a few:

   Conexant CX82100, P52
   Triscend A7V, A7S
   Net+ARM 15, 40, 50
   TI DSC21, 5471
   Samsung S3C3410, S3C4530, S3C4510
   Atmel AT91 R40807

I am sure there is more...

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

