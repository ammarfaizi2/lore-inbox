Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTIOQVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbTIOQVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:21:23 -0400
Received: from peabody.ximian.com ([141.154.95.10]:10711 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261538AbTIOQVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:21:19 -0400
Message-ID: <3F65E6D6.6090001@ximian.com>
Date: Mon, 15 Sep 2003 12:20:38 -0400
From: Kevin Breit <mrproper@ximian.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need fixing of a rebooting system
References: <1063496544.3164.2.camel@localhost.localdomain>  <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>  <3F6450D7.7020906@ximian.com>  <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com> <1063561687.10874.0.camel@localhost.localdomain> <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com> <3F64FEAF.1070601@ximian.com> <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Sun, 14 Sep 2003, Kevin Breit wrote:
>
>  
>
>>This unfortunately didn't help.  It still reboots right after it 
>>uncompresses the kernel.
>>    
>>
>
>Please try the attached .config, if that works, start removing things like 
>ACPI from your configuration.
>
Bah!  I wasn't thinking this morning.  I ran a make menuconfig and now 
I'm running make, so ignore my last message.  I'll reply later about the 
new kernel.

Thanks

Kevin Breit

