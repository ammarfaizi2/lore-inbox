Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312843AbSDBQV3>; Tue, 2 Apr 2002 11:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312842AbSDBQVK>; Tue, 2 Apr 2002 11:21:10 -0500
Received: from eclipt.uni-klu.ac.at ([143.205.176.100]:50696 "EHLO
	eclipt.uni-klu.ac.at") by vger.kernel.org with ESMTP
	id <S312841AbSDBQU7>; Tue, 2 Apr 2002 11:20:59 -0500
Subject: APIC error on single processor notebook
From: Martin Preishuber <martin.preishuber@eclipt.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Apr 2002 17:21:01 +0200
Message-Id: <1017760861.1849.39.camel@daddy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently installed Debian on my Acer Travelmate 613 XTC and get the
following boot messages:

APIC error on CPU0: 08(08)

I checked the list archives and only found reports about that on SMP
machines or with some VIA chipset.

The kernel I use is 2.4.18, the chipset is some Intel 82815 controller.
Some other strange thing is, that the message occurs very often after a
cold reboot, but not after some warm reboot (e.g. after starting linux
after having run win2k)

The machine runs perfectly stable, I just thought someone out there
might be interested ;-)

Martin

-- 
Martin Preishuber - IT Expert, Student, SysAdmin
http://www.eclipt.at, mailto:Martin.Preishuber@eclipt.at

"They that can give up essential liberty to obtain a little temporary
saftey deserve neither liberty not saftey."
-- Benjamin Franklin, 1759

