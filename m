Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUJEVBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUJEVBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUJEVBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:01:17 -0400
Received: from homepage-center.de ([216.121.191.204]:3854 "EHLO
	homepage-center.de") by vger.kernel.org with ESMTP id S265971AbUJEVBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:01:05 -0400
Message-ID: <416308B6.7070403@visual-page.de>
Date: Tue, 05 Oct 2004 22:48:54 +0200
From: Christian Gmeiner <christian@visual-page.de>
Reply-To: christian@visual-page.de
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: I2C Interface changes sinse 2.6.8.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I want to use the current cvs of the dxr3 drivers with the 2.6.9-rc3. I 
want to get the modules running with the new rc3 - with your help.

When i load the adv717xa.ko module i get this error:
adv717xa.o: called for an ISA bus adapter?!?

The module loaded very well under 2.6.8.1, so could somebody tell me 
what have exactly changed - i ma not sure what to search for in the 
ChangeLogs.

Here you can look at the module source:
http://cvs.sourceforge.net/viewcvs.py/dxr3/em8300/modules/adv717x.c?rev=1.42&view=auto

Thanks,
Christian

