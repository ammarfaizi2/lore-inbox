Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286232AbRL0KAQ>; Thu, 27 Dec 2001 05:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286233AbRL0KAF>; Thu, 27 Dec 2001 05:00:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29958 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S286232AbRL0J77>; Thu, 27 Dec 2001 04:59:59 -0500
Message-ID: <3C2AEE8B.9040507@evision-ventures.com>
Date: Thu, 27 Dec 2001 10:48:59 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011212
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: rbector@andiamo.com
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: supporting more than 4K output via /proc
In-Reply-To: <GIEMIEJKPLDGHDJKJELAEEALDIAA.rbector@andiamo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:

>Hi
> Could somebody point me to some code which implements
>outputting more than 4K data via /proc interface. Is there
>a nice and clean way to do it ?
>

Yes there is: ioctrl().


