Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265350AbRFVGaU>; Fri, 22 Jun 2001 02:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265349AbRFVGaK>; Fri, 22 Jun 2001 02:30:10 -0400
Received: from ip65.levi.spb.ru ([212.119.175.65]:56774 "EHLO
	germes.levi.spb.ru") by vger.kernel.org with ESMTP
	id <S265348AbRFVG3t>; Fri, 22 Jun 2001 02:29:49 -0400
Message-ID: <3B32E5C5.2040401@levi.spb.ru>
Date: Fri, 22 Jun 2001 10:29:25 +0400
From: Anatoly Ivanov <avi@levi.spb.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010619
X-Accept-Language: en-us
MIME-Version: 1.0
To: Fabian Arias <dewback@vtr.net>
CC: "Kissandrakis S. George" <kissand@phaistosnetworks.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
In-Reply-To: <Pine.LNX.4.21.0106212143320.9295-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you can see, this is just deprecation warning,
i.e. you can use multi-string literals, but
you'd better don't.

You can forget about these warnings and test ac17
with gcc3.

I hope that lk-developers would fix it one day.

---
avi

Fabian Arias wrote:

> I've just applied the "patch", but te warning still appears. Is this
> somthing not to be worried about or is it something serious?
> 
> /usr/src/linux-2.4.5/include/asm/checksum.h:161:17: warning: multi-line
> string literals are deprecated
> 
> I had to come back to 2.95 to test the ac17. Not so happy about it. :(
> 
> Please give me some directions.
> 
> On Wed, 20 Jun 2001, Anatoly Ivanov wrote:
> 


