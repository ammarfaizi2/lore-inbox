Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKRI7G>; Mon, 18 Nov 2002 03:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSKRI7F>; Mon, 18 Nov 2002 03:59:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261721AbSKRI7F>;
	Mon, 18 Nov 2002 03:59:05 -0500
Message-ID: <3DD8AD5D.9010803@pobox.com>
Date: Mon, 18 Nov 2002 04:05:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vergoz Michael wrote:

> Hi Jeff,
>
> What i see is the current driver _doesn't_ work on my realtek 8139C.
> With this one it work fine.


What does not work?  Does the driver load?  Can you ping?  Does the 
driver work for a little while then stop?  Does it work perfectly except 
under heavy load?

Also, please read "REPORTING-BUGS" file in a Linux kernel source tree 
for additional debugging information to provide (lspci, dmesg, etc.)

Your patch includes so much junk it is obviously unacceptable. 
Therefore, I request that you work with me (and other kernel developers) 
to narrow down the problem, so that it may be fixed.

Regards,

	Jeff



