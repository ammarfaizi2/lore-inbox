Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTIPCpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTIPCpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:45:04 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:32439 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S261761AbTIPCpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:45:00 -0400
Message-ID: <3F66792B.8090805@genebrew.com>
Date: Mon, 15 Sep 2003 22:44:59 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030908 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Breit <mrproper@ximian.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need fixing of a rebooting system
References: <1063496544.3164.2.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>	 <3F6450D7.7020906@ximian.com>	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>	 <1063561687.10874.0.camel@localhost.localdomain>	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>	 <3F64FEAF.1070601@ximian.com>	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>	 <1063650478.1516.0.camel@localhost.localdomain> <1063653132.224.32.camel@clubneon.priv.hereintown.net> <3F66249A.3020308@ximian.com>
In-Reply-To: <3F66249A.3020308@ximian.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [141.152.250.151] at Mon, 15 Sep 2003 21:44:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Breit wrote:

> * Machine Check Exception
> * /dev/cpu/microcode
> * /dev/cpu/*/msr
> * /dev/cpu/*/cpuid
> * BIOS Enhanced Disk Drive calls determine boot disk
> * Power Management support
>   *Full ACPI Support (minus the ASUS Laptop Extras and Toshiba Laptop 
> Extras)

I would turn off all of these. None of them should be necessary. You cab 
turn ACPI back on afterwards to see if it works again.

-Rahul
--
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

