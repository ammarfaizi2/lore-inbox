Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136856AbREJQwT>; Thu, 10 May 2001 12:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136854AbREJQwJ>; Thu, 10 May 2001 12:52:09 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:13137 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S136852AbREJQvw>;
	Thu, 10 May 2001 12:51:52 -0400
Message-ID: <3AFAC71F.3E6734FE@violin.dyndns.org>
Date: Thu, 10 May 2001 18:51:44 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Curious boot problem: linux-2.4.4SMP/AsusTek MB
In-Reply-To: <3AFAC3E2.6BA7D8C0@vbfx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A friend of mine uses linux-2.4.4 on his nice dual P3-1000 machine
(AsusTek Motherboard). The problem is that the kernel gets stuck at the
initialization of the APIC during boottime. The real weird thing is that
if he boots linux-2.2.18 and afterwards 2.4.4, the kernel boots
properly. So it seems that kernel 2.2 does some "initalization" that
helps 2.4.4 to boot.

Does anyone have a clue?

		Best Regards,
		Hermann

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
