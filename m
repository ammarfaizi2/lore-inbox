Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTLIDzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTLIDzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:55:09 -0500
Received: from adsl-b3-74-34.telepac.pt ([213.13.74.34]:60859 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S262738AbTLIDzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:55:04 -0500
Message-ID: <3FD54858.3000009@vgertech.com>
Date: Tue, 09 Dec 2003 03:58:16 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA on-chip RNG and crypto...
References: <3FD50CD6.3070808@pobox.com>
In-Reply-To: <3FD50CD6.3070808@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

Jeff Garzik wrote:
> 
> VIA has publicly posted the docs for the 'xstore' and 'xcrypt' 
> instructions in their processors:
> 
>     http://www.via.com.tw/en/viac3/c3.jsp
> 
> (grab "VIA Padlock {ACE|RNG} Programming Guide" down at the bottom)
> 


You forgot the "journalist touch". To spike interest:

"PadLock ACE encrypts at rates of up to 12.5 Gigabits per second (Gbps) 
with a 1GHz VIA C3 processor, more than eight times faster than the best 
software AES implementation from a power hungry 3GHz Intel® Pentium® 4 
processor based system that encrypts at a rate of a mere 1.5 Gbps."

25 times faster, clock by clock :)

Regards,
Nuno Silva

[...]

> 
> P.S. In the interest of full disclosure, neither VIA nor my employer 
> prompted me to write this.
> 

The same here.


