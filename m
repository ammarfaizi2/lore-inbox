Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbSJLTRn>; Sat, 12 Oct 2002 15:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbSJLTRn>; Sat, 12 Oct 2002 15:17:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39832 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261328AbSJLTRk>;
	Sat, 12 Oct 2002 15:17:40 -0400
Message-ID: <3DA87675.1050004@us.ibm.com>
Date: Sat, 12 Oct 2002 12:22:29 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
References: <Pine.LNX.4.33.0210111009170.4030-100000@maxwell.earthlink.net> <1749543871.1034360975@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>This patch fixes some of the missed handle_sysrq functions not updated.
>>please apply.
> 
> Are you going to have early console support (ie printk from before
> what is now console_init) done before the freeze, or should I just 
> submit our version?

That reminds me.  Has anyone noticed that sysrq on the serial console 
is broken?

-- 
Dave Hansen
haveblue@us.ibm.com

