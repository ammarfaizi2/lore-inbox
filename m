Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUKWST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUKWST7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUKWSSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:18:22 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28405 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261469AbUKWSQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:16:11 -0500
Message-ID: <41A37E5C.8050305@in.ibm.com>
Date: Tue, 23 Nov 2004 23:45:56 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
References: <419CACE2.7060408@in.ibm.com>	 <20041119153052.21b387ca.akpm@osdl.org>	 <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>	 <200411201204.37750.amgta@yacht.ocn.ne.jp>  <41A20DB5.2050302@in.ibm.com> <1101170617.4987.268.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1101170617.4987.268.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

Badari Pulavarty wrote:
> More info testing results...
> 
> gdb is not showing the stack info properly, on my saved vmcore.
> I thought vmlinux is not matching the vmcore, so I verified that
> vmcore and vmlinux matchup. But still no luck...

I will try to recreate this using the 'sysrq' method you described in 
the earlier mail. Will let you know my findings asap.

Thanks very much for trying kdump!

Regards, Hari
