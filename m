Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbULBQFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbULBQFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbULBQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:02:33 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:30689 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261676AbULBQAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:00:43 -0500
Message-ID: <41AF3EC3.7060807@devicelogics.com>
Date: Thu, 02 Dec 2004 09:11:47 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to understand flow of kernel code
References: <41AE9E3E.9020307@globaledgesoft.com>
In-Reply-To: <41AE9E3E.9020307@globaledgesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hare Krishna, Hare Krishna, Krishna, Krishna, Hare, Hare,
Hare Rama, Hare Rama, Rama, Rama, Hare, Hare.

Start at entry.S and head.S in /arch/i386/kernel and trace the 
initialization. It's a good place
to start for understanding how the kernel boots and follow the code 
through init. Check out
the userspace interaction as well. It will at least start you with the 
basics.

You may want to offer a leaf, fruit, flower, and water to Lord Chaitanya 
and Lord Krishna
and chant the mantras in between to ask for guidance and understanding 
(I'm serious).

Interesting trivia. Krishna in hindi means "all attractive". The Greeks 
took the word and
over time it was corrupted into the word "Christ" which was later used 
for Jesus of Nazereth.
I lot of people probably don't know his last name actually came from the 
Vedic culture.

Hare Krishna,

Jeff

krishna wrote:

> Hi,
>
> Can Anyone tell me the tips/tricks/techniques/practices followed in 
> understanding flow of Linux kernel code?
>
> Regards,
> Krishna Chaitanya
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

