Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbUJ0Xcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUJ0Xcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUJ0UwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:52:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:31381 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262724AbUJ0Uqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:46:33 -0400
Message-ID: <41800675.5090806@osdl.org>
Date: Wed, 27 Oct 2004 13:35:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue... [u]
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>	 <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>	 <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>	 <200410261442.11618.vda@port.imtp.ilyichevsk.odessa.ua>	 <20041026203137.GB10119@thundrix.ch>  <417F2251.7010404@zytor.com> <1098908018.12420.81.camel@nosferatu.lan>
In-Reply-To: <1098908018.12420.81.camel@nosferatu.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer [c] wrote:
> On Tue, 2004-10-26 at 21:21 -0700, H. Peter Anvin wrote:
> 
>>Tonnerre wrote:
>>
>>>Salut,
>>>
>>>On Tue, Oct 26, 2004 at 02:43:54PM +0300, Denis Vlasenko wrote:
>>>
>>>
>>>>Having /usr/XnnRmm was a mistake in the first place.
>>>
>>>
>>>BSD has /X11R6, whilst I'd agree that /opt/xorg is probably a lot more
>>>appropriate. If you want I can  take this discussion back to the X.Org
>>>folks again, but I don't think it's actually going to change anything.
>>>
>>
>>/opt/X (or /usr/X) is really what it probably should be.
>>
> 
> 
> Except if I am missing something, it is (or was) to be able to
> distinguish between versions that broke protocol compatibility ...
> so except if the protocol will never change again, it should really
> stay as is, and the apps should actually just start to use /usr/bin/X11
> and /usr/lib/X11 that points to the latest or most stable instead of
> the versioned directories ...

This won't get fixed on lkml.
If you want to contribute in this area, try LSB/FHS etc.  & Please do.

-- 
~Randy
