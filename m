Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTELT7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTELT7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:59:00 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:15316 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S262571AbTELT67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:58:59 -0400
Date: Tue, 13 May 2003 08:11:40 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
Message-ID: <71066878.1052813500@[192.168.1.249]>
In-Reply-To: <200305120620.h4C6K64j061741@ns.indranet.co.nz>
References: <3191078.1052695705@[192.168.1.249]>
 	<17308.1052658225@www4.gmx.net>	<443147.1052742876@[192.168.1.249]>
 <200305120620.h4C6K64j061741@ns.indranet.co.nz>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 12 May 2003 8:17 a.m. +0200 Tuncer M zayamut Ayaz 
<tuncer.ayaz@gmx.de> wrote:


> one thing none of you most probably wants to hear:
> if this "APM idle calls" is that "HLT" stuff, then I have to tell you
> that on win32 I had not such problems while using the CpuIdle tool.
> sorry.

No, HLT on idle is always on in Linux.  APM idle is a separate feature, 
which Windows never did (although Windows does do the equivalent thing with 
ACPI).


> any PCMCIA fixes already available in linus -bk?

I don't know.

>
> does CpuFreq depend on ACPI ? just in case i8k1 doesn't have proper
> ACPI support.

No, it doesn't depend on ACPI.

