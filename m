Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317543AbSGETch>; Fri, 5 Jul 2002 15:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSGETcg>; Fri, 5 Jul 2002 15:32:36 -0400
Received: from chabotc.xs4all.nl ([213.84.192.197]:27572 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317543AbSGETcg>; Fri, 5 Jul 2002 15:32:36 -0400
Message-ID: <3D25F4DC.2040404@xs4all.nl>
Date: Fri, 05 Jul 2002 21:34:52 +0200
From: Chris Chabot <chabotc@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel PRO/Wireless 5000 support?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A question for all you out there. Is there any way to get the Intel 
PRO/Wireless 5000 pcmcia cards working?
(that are those new 54 Mbs 801.11a pcmcia cards)

I've got a couple here playing very non alive and non detected under linux.

ps, lspci -v reports it as:

09:00.0 Ethernet controller: Unknown device 168c:0007 (rev 01)
        Subsystem: Intel Corp.: Unknown device 2500
        Flags: medium devsel, IRQ 10
        Memory at f2800000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2

Any info is greatly apreciated

    -- Chris Chabot

