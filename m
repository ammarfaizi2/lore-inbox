Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSGVXic>; Mon, 22 Jul 2002 19:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSGVXic>; Mon, 22 Jul 2002 19:38:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317893AbSGVXib>;
	Mon, 22 Jul 2002 19:38:31 -0400
Message-ID: <3D3C9848.4050802@mandrakesoft.com>
Date: Mon, 22 Jul 2002 19:42:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Weber <john.weber@linux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: New Xircom Cardbus Driver for 2.5?
References: <3D3C8D08.3060107@linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:
> I searched the archives, but couldn't find anything about the new xircom 
> 32-bit cardbus driver for linux 2.5.  Can anyone give me some pointers?


There is no new xircom cardbus driver.  It has the same drivers as 2.4, 
"xircom_cb" and "xircom_tulip_cb"  I believe these were in the 
drivers/net/pcmcia directly in 2.4.

	Jeff




