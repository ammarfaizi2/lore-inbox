Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVISEXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVISEXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVISEXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:23:44 -0400
Received: from mail.ctyme.com ([69.50.231.10]:19373 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S932220AbVISEXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:23:43 -0400
Message-ID: <432E3D4C.4070508@perkel.com>
Date: Sun, 18 Sep 2005 21:23:40 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Lost Ticks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Maindomain: perkel.com
X-Spam-filter-host: newton.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a dual core Athlon 64 X2 on an Asus board using NVidia chipset and 
getting lost ticks. The software clock of course is totally messed up. 
I've scanned google for a solution and see others complaining about bad 
code in the SMM BIOS. I have the latest bios and whatever they need to 
fix - isn't.

So - what do I do to make it work?

Yes - I compiled the kernel 2.6.13.1 and used a speed of 100 - the 
lowest setting - and that did help some. But - the problem needs to go away.

If I compile a kermel without any of the power management at all - will 
that fix the problem? I need a work around.

Thanks in advance.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

