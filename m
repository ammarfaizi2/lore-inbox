Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTCFGov>; Thu, 6 Mar 2003 01:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTCFGov>; Thu, 6 Mar 2003 01:44:51 -0500
Received: from smtp02.web.de ([217.72.192.151]:60934 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S266994AbTCFGov>;
	Thu, 6 Mar 2003 01:44:51 -0500
Message-ID: <3E66F185.4020201@web.de>
Date: Thu, 06 Mar 2003 07:58:13 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with rebooting on an HP Omnibook vt6200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have a new HP Omnibook vt6200, on which I tried to install Linux. 
Installation succeeded but the reboot doesn't. Nor a complete shutdown 
does. The machine does nothing more after showing the messages 
"Restarting the system" or "Power down". So here is the data:
Prozessor: Pentium4 1,7 GHz
Bridge: ALi 1671
BIOS: Phoenix, current HP revision EG.M.2.31
 From the kernels I tried 2.4.20 with both APM and ACPI and with no 
power management at all. There was no swith in the bios setup to try and 
shut off power management at all. Since the kernel does not bail out, 
how do I find some more insightful information on what is going on?

I'd be glad to get any information from you guys, even if it is only 
that it won't work so I can  return the laptop and choose another one...TIA

Regards,
Todor

