Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTLaOlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTLaOlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:41:13 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:1668 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265144AbTLaOlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:41:11 -0500
Message-ID: <3FF2E002.5010308@blue-labs.org>
Date: Wed, 31 Dec 2003 09:41:06 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: APCUPSD and HID spam
References: <3FF257A0.8070906@blue-labs.org> <20031231091406.A22231@mail.kroptech.com>
In-Reply-To: <20031231091406.A22231@mail.kroptech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:

>>Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
>>queue full
>>    
>>
>
>Known bug. Upgrade apcupsd to 3.10.8 or the kernel to 2.6.1-rc1.
>
>FYI, in the future you should direct inquiries regarding apcupsd to the
>apcupsd-users list (apcupsd-users@lists.sourceforge.net) and search its
>archive where bugs such as this tend to be well known.
>  
>

Sure, but it looked like a kernel bug so I sent it to LKML and I only 
saw 3.10.6 on the apcupsd page.  I didn't go to the download page to verify.

Thanks,
David

