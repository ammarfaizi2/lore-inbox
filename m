Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311692AbSCZNRa>; Tue, 26 Mar 2002 08:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311602AbSCZNRU>; Tue, 26 Mar 2002 08:17:20 -0500
Received: from ip212-226-163-33.adsl.kpnqwest.fi ([212.226.163.33]:36790 "HELO
	mail.ftlight.net") by vger.kernel.org with SMTP id <S311692AbSCZNRM>;
	Tue, 26 Mar 2002 08:17:12 -0500
Message-ID: <3CA074D5.5080902@ftlight.net>
Date: Tue, 26 Mar 2002 15:17:09 +0200
From: Mattias Nordstrom <matta@ftlight.net>
Organization: ftlight.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Asus A7V133 BIOS Update fixed kernel crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just thought I should share this with the kernel developer community. 
When I was running my system (AMD Athlon XP 1700+ with Asus A7V133-C) 
with the default BIOS on the motherboard (1007) I experienced several 
problems when trying to run programs. Most of them either Segfaulted or 
caused a bus error. The crashes where usually related to situations 
where a program tried to display an animation or a video. Sometimes the 
system completely froze. I tried to compile the kernel with all kinds of 
different options, tried with and without athlon optimization but 
nothing seemed to work. I thought it might have been related to the 
"Athlon/AGP bug", but the solutions to fix the bug did not work for my 
system.

Then one day I happened to check Asus homepage and found a BIOS update 
for my motherboard. I flashed my BIOS with the new software (1008) and 
now I haven't had any problems. The BIOS came out 8.3.2002, so it's 
quite new. Anyone happen to know what changes where made in the new BIOS 
which solved my problem?

-- 
Mattias Nordström
matta@ftlight.net
-www.ftlight.net-


