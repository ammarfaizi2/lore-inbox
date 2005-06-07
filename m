Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVFGP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVFGP34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVFGP1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:27:31 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23305 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261907AbVFGPEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:04:55 -0400
Message-ID: <42A5B80A.4040709@tmr.com>
Date: Tue, 07 Jun 2005 11:06:50 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Pentium-D support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is really a question in several areas I'll put it here. Now 
that the Pentium-D processors are available at reasonable prices and for 
quick delivery, can anyone speak to the ACPI issues? The available 
boards use the 945 and 955 chipset. Is there any reason to think that 
the scheduler would get confused by the CPU, such as thinking it was HT 
or some such?

The specs indicate that 64 bit is supported, is there any actualy Linux 
support for the Intel 64 bit stuff in gcc and the kernel? One of the 
people I work with reports that the distro he runs on his Athlon64 lock 
solid after reading the boot sector, so obviously this isn't Athlon 
compatable.

The price is lower than a dual Xeon setup if you have an application 
which needs SMP, and initial power values make it look like a lower 
power solution overall.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
