Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTIPCre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTIPCre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:47:34 -0400
Received: from [141.154.95.10] ([141.154.95.10]:4065 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S261768AbTIPCrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:47:32 -0400
Subject: Re: Need fixing of a rebooting system
From: Kevin Breit <mrproper@ximian.com>
Reply-To: mrproper@ximian.com
To: Chris Meadors <clubneon@hereintown.net>
Cc: Kevin Breit <mrproper@ximian.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
X-Accept-Language: en-us, en
References: <1063496544.3164.2.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
	 <3F6450D7.7020906@ximian.com>
	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>
	 <1063561687.10874.0.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>
	 <3F64FEAF.1070601@ximian.com>
	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
	 <1063650478.1516.0.camel@localhost.localdomain>
	 <1063653132.224.32.camel@clubneon.priv.hereintown.net>
	 <3F66249A.3020308@ximian.com>
	 <1063664654.19299.10.camel@clubneon.clubneon.com>
In-Reply-To: <1063664654.19299.10.camel@clubneon.clubneon.com>
Content-Type: text/plain
Organization: Ximian, Inc.
Message-Id: <1063680432.2128.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 22:47:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:

>On Mon, 2003-09-15 at 16:44, Kevin Breit wrote
>
>>* Preemptible Kernel
>>* Machine Check Exception
>>* /dev/cpu/microcode
>>* /dev/cpu/*/msr
>>* /dev/cpu/*/cpuid
>>* BIOS Enhanced Disk Drive calls determine boot disk
>>    
>>
>
>I'd turn this off, just to see if it makes any change.  It says it is
>"believed to be safe", but it is experimental, and your controller BIOS
>almost surely does not support it.
>
>  
>
Disabling this didn't fix anything.

Kevin


