Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWDXR00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWDXR00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWDXR00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:26:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3256 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751022AbWDXR0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:26:25 -0400
Message-ID: <444D0A3E.6070107@watson.ibm.com>
Date: Mon, 24 Apr 2006 13:26:22 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 1/8] Setup
References: <444991EF.3080708@watson.ibm.com>	<4449939D.7@watson.ibm.com> <20060423190232.2fe43995.rdunlap@xenotime.net>
In-Reply-To: <20060423190232.2fe43995.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Fri, 21 Apr 2006 22:23:25 -0400 Shailabh Nagar wrote:
>
>  
>
>>Index: linux-2.6.17-rc1/include/linux/delayacct.h
>>===================================================================
>>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>+++ linux-2.6.17-rc1/include/linux/delayacct.h	2006-04-21 19:39:29.000000000 -0400
>>@@ -0,0 +1,69 @@
>>+/* delayacct.h - per-task delay accounting
>>+ */
>>+
>>+#ifndef _LINUX_TASKDELAYS_H
>>+#define _LINUX_TASKDELAYS_H
>>    
>>
>
>Probably _LINUX_DELAYACCT_H.
>  
>
Yup. Hangover from old name...will fix.

>Or if I add linux/taskdelays.h, what #include guard should I use?
>
>---
>~Randy
>  
>

