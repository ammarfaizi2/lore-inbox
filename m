Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCSCSf>; Mon, 18 Mar 2002 21:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCSCSZ>; Mon, 18 Mar 2002 21:18:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293521AbSCSCSU>;
	Mon, 18 Mar 2002 21:18:20 -0500
Message-ID: <3C969FC5.10504@mandrakesoft.com>
Date: Mon, 18 Mar 2002 21:17:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Ed Vance <EdV@macrolink.com>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: PCI drivers - memory mapped vs. I/O ports
In-Reply-To: <Pine.LNX.3.95.1020318152604.29558A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Mon, 18 Mar 2002, Ed Vance wrote:
>
>>If a PCI device can be programmed equally well via I/O port space or memory
>>space, what are the reasons to chose one space over the other when writing
>>the driver?
>>

>Basically, if you have a choice, it's hands-down to use memory-mapped
>I/O space.
>

Yep, I couldn't agree more.

    Jeff




