Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSKGPsq>; Thu, 7 Nov 2002 10:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSKGPsp>; Thu, 7 Nov 2002 10:48:45 -0500
Received: from quark.didntduck.org ([216.43.55.190]:28946 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S261319AbSKGPsj>; Thu, 7 Nov 2002 10:48:39 -0500
Message-ID: <3DCA8CCE.5090503@didntduck.org>
Date: Thu, 07 Nov 2002 10:54:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
References: <20021107145112.GA24278@suse.de>  <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> <20021104025458.GA3088@zip.com.au> <9668.1036679581@passion.cambridge.redhat.com> <11262.1036680930@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> davej@codemonkey.org.uk said:
> 
>> Relatively pointless given that there are more and more boxes out
>>there that won't boot without ACPI these days.
> 
> 
> There are also more and more boxes out there which won't run X without the
> nvidia driver loaded. Does that mean we shouldn't bother to record that 
> information either?
> 
> I'm not necessarily suggesting we should automatically ignore all reports 
> with the 'BIOS' taint flag set as we do the 'Proprietary' flag; just that 
> it should be reported.

You only need the binary driver for 3D support.  XFree86 runs fine 
without it for 2D.

--
				Brian Gerst


