Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbRFQEmu>; Sun, 17 Jun 2001 00:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264691AbRFQEmk>; Sun, 17 Jun 2001 00:42:40 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:37760 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S264690AbRFQEm3>;
	Sun, 17 Jun 2001 00:42:29 -0400
Message-ID: <3B2C351A.5030901@aquazul.com>
Date: Sun, 17 Jun 2001 06:42:02 +0200
From: Mourad De Clerck <mourad@aquazul.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac13 i686; en-US; rv:0.9.1) Gecko/20010612
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More spontaneous reboots with 440LX chipsets (2.4.5ac7)
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

But ever since the 2.4 series (i used 2.4.3, 2.4.4acXX, and now 
2.4.5ac7) i get spontaneous reboots quite often. Usually it isn't doing 
anything fancy when it happens, no harddisk activity or memory pressure, 
it just pops and croaks.

I'm using reiserfs by the way.

Just thought i'd mention it, because i've seen other people having 
spontaneous reboots with LX chipsets.

Mourad DC

