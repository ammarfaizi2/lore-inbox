Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272451AbRIFLqW>; Thu, 6 Sep 2001 07:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272458AbRIFLqN>; Thu, 6 Sep 2001 07:46:13 -0400
Received: from femail41.sdc1.sfba.home.com ([24.254.60.35]:2435 "EHLO
	femail41.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272451AbRIFLqG>; Thu, 6 Sep 2001 07:46:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: Early results and more information needed (K7/Athlon optimization problems)
Date: Thu, 6 Sep 2001 04:45:52 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090604455200.00176@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've only had a half-dozen responses so far, please keep sending 
information as detailed in my last message!

I do have an early thought though.
Everyone who's reported the requested information to me and had problems 
has been using the VIA KT133A chipset, this isn't in itself surprising, 
it's been a pattern that's already been noted.
However, I do have one report of no-problems on a VIA KT133A chipset, and 
it differs in one major way from the rest, the FSB speed is 100Mhz(200), 
whereas all the others are running at 133Mhz(266). This partialy fits my 
suspicion that something, somewhere, is clock speed related, since, when 
running at rated speeds, nothing below a certain level (I think about 
1Ghz) is running with a 133Mhz FSB, and many chips above that level are 
running at 133Mhz.

I still need more reports, the information previously requested is this:

--previous request--
Motherboard + chipset
Front Side Bus speed
CPU speed + multiplier
out put of "cat /proc/cpuinfo"
if avalible, RAM type and speed (both clock and CAS latency)
if avalible, PSU wattage, and amperage on all outputs.
--end previous request--

Also, I need another peice of specific information, is anyone running a 
VIA KT133A chipset with a 133Mhz(266) FSB, and NOT experiencing problems? 
And if you're not, are you running a chip rated for 133Mhz FSB operation 
or not?

Thanks,
-NK
