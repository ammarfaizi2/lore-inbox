Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSL2SNr>; Sun, 29 Dec 2002 13:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSL2SNr>; Sun, 29 Dec 2002 13:13:47 -0500
Received: from [218.104.80.12] ([218.104.80.12]:46285 "HELO netspeed-tech.com")
	by vger.kernel.org with SMTP id <S261290AbSL2SNq>;
	Sun, 29 Dec 2002 13:13:46 -0500
Message-ID: <3E0F3C6F.3090701@netspeed-tech.com>
Date: Mon, 30 Dec 2002 02:18:23 +0800
From: zhaoway <zw@netspeed-tech.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3b) Gecko/20021225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rol@as2917.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.5.53
References: <200212291837.09152.rol@as2917.net>
In-Reply-To: <200212291837.09152.rol@as2917.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could write a simple script to install a kernel image and 
install the .config under /boot as well. Guess that solves your 
problem better.

Regards,

Paul Rolland wrote:
> Hello,
> 
> Here is the 2.5.53 version of the patch I just sent to the list for 2.4.20
> Main differences are in the Makefile and Kconfig. the C source code hasn't changed.
> 
> This has been tested on a standard 2.5.53 without problem, just one important
> point : you need to activate /proc support.
> 
> This constraint is not present in the Kconfig entry, as I don't know how to do.
> Any idea welcome...
> 
> Regards,
> Paul Rolland, rol@as2917.net

