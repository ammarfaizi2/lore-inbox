Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbRGNVdE>; Sat, 14 Jul 2001 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRGNVcy>; Sat, 14 Jul 2001 17:32:54 -0400
Received: from hercules.telenet-ops.be ([195.130.132.33]:52668 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S264877AbRGNVct>;
	Sat, 14 Jul 2001 17:32:49 -0400
Message-ID: <3B50BA77.7040101@aquazul.com>
Date: Sat, 14 Jul 2001 23:32:39 +0200
From: Mourad De Clerck <mourad@aquazul.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac15 i686; en-US; rv:0.9.1) Gecko/20010620
X-Accept-Language: en, en-us, nl-be, nl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Still spontaneous reboots with 440LX chipsets (2.4.7-pre6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have a Soltek AT motherboard with
- a 440LX/EX chipset
- a celeron 533
- 96 mb of ram (tested with memtest86, just to be sure)
- an ATI rage pro (agp)
- a western digital harddisk
- a 3c509b

that's it, nothing fancy.

But ever since the 2.4 series (i used 2.4.3, 2.4.4acXX, 2.4.5ac7 and now 
2.4.7-pre6) i get spontaneous reboots quite often. Usually it isn't 
doing anything fancy when it happens, no harddisk activity or memory 
pressure, it just pops and croaks.

I'm using reiserfs by the way.


I've mentioned this before, but it's still not solved with the newer 
versions.

Someone told me to not load the agp support, but this didn't help either.

(btw: I tested the memory with memtest, i checked the fan of the cpu, 
and the cpu is not overclocked.)

Just thought i'd mention it, because i've seen other people having
spontaneous reboots with LX chipsets.



Thanks,

Mourad DC


