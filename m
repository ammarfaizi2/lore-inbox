Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTHSVeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSVaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:30:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37296 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261473AbTHSV3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:29:36 -0400
Message-ID: <3F4296B4.3050505@pobox.com>
Date: Tue, 19 Aug 2003 17:29:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: walt <wa1ter@myrealbox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Broadcom gigabit ethernet question for Jeff?
References: <3F428E5C.80801@myrealbox.com>
In-Reply-To: <3F428E5C.80801@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Hi, it's me again.  Sorry to be back, but 2.6 is looming and I still 
> have the
> same old problem with my Asus A7V8X with builtin Broadcom chip.
> 
> If you'll recall I must do an ifconfig down/up cycle to get the chip to 
> transmit
> any packets.  Once I do that the chip works fine until the next reboot.  
> See lkml
> archives for March 5.

I'll take a look.


> This problem first appeared in 2.4.21-rc5.  Before that the chip worked 
> fine for me.

Now that's an interesting piece of information.  I'll take a look at 
what changes in -rc5..

	Jeff



