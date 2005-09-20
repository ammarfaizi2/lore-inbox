Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVITPJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVITPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVITPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:09:28 -0400
Received: from 69.50.231.10.ip.nectartech.com ([69.50.231.10]:40146 "EHLO
	newton.ctyme.com") by vger.kernel.org with ESMTP id S964834AbVITPJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:09:27 -0400
Message-ID: <43302616.6000908@perkel.com>
Date: Tue, 20 Sep 2005 08:09:10 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lost Ticks - TSC Timer - AMD 64 X2 Processor - What's up with that?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-filter-host: newton.ctyme.com - http://www.junkemailfilter.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having timer problems. About to head to the data center to try different 
things to get this server to work right. Losing ticks and clock is all 
over the place and doing obscene things to keep it almost on track - but 
I really need a solution.

Running 2.6.13.1 Kernel - FC4 Linux - Asus Motherboard - A8N-SLI 
Premium. Athlon X2 4400+ with 4 gigs of ram and it uses some sort of 
memory remapping to use the full 4 gigs.

I don't understand all the different timers. There's TSC and PM and what 
else?

Someone suggested "notsc" which I will try when I get there. But  - 
looking for a list of other things to try as well. I have flashed the 
latest BIOS.

I'm thinking about giving up and going back to DOS. I didn't have these 
problem with DOS - and DOS boots faster. ;)

Tell me about all these timers - what are my choices - and what is most 
likely to actually work.

Thanks in advance.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

