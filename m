Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUHTQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUHTQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUHTQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:30:16 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:14747 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S268310AbUHTQaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:30:05 -0400
Message-ID: <41262709.5000508@tomt.net>
Date: Fri, 20 Aug 2004 18:30:01 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Admin@ZoneServ.com
Subject: Re: Driver missing, 3ware 9000.
References: <003001c486d6$136e5e20$0100a8c0@coolman>
In-Reply-To: <003001c486d6$136e5e20$0100a8c0@coolman>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gil Binder wrote:
> Hello Kernel developers,
> I just got a new machine with 3ware 9000 (raid controller).
>  
> And when I make the initrd image it says, a driver is missing - 3x-9xxx
> which is 3ware 9000 device.
>  
> What should I do? Am I doing something wrong? Or you just don't have any
> support of 3x-9xxx in any of the kernel source additions?

the 3w-9xxx drivers got included in mainline kernel at version 2.6.8(.1).

-- 
Cheers,
André Tomt
