Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266402AbSKGHql>; Thu, 7 Nov 2002 02:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266403AbSKGHql>; Thu, 7 Nov 2002 02:46:41 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:55776 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S266402AbSKGHqk>; Thu, 7 Nov 2002 02:46:40 -0500
Message-ID: <3DCA1C1A.1080406@snapgear.com>
Date: Thu, 07 Nov 2002 17:54:02 +1000
From: gerg@snapgear.com
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Console init revamp.
References: <3DCA166C.7080009@snapgear.com>  <8025.1036600362@passion.cambridge.redhat.com> <6047.1036654879@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Woodhouse wrote:
> gerg@snapgear.com said:
> 
>> That has been on my todo list for a while :-)
>>I should have them all cleaned up into a single vmlinux.lds.S file by
>>end of today or tomorrow.
> 
> 
> You know, the rest of the vmlinux.lds.S files could also do with a little 
> #include loving, while you're at it... :)

Hah!  I think the 28 or so we have under the m68knommu arch
outnumbers all others in the kernel sources put together :-)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

