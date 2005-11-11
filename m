Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVKKKRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVKKKRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVKKKRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:17:55 -0500
Received: from mxout5.cac.washington.edu ([140.142.32.135]:38803 "EHLO
	mxout5.cac.washington.edu") by vger.kernel.org with ESMTP
	id S1751267AbVKKKRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:17:54 -0500
X-Auth-Received: from [192.168.1.101] (c-24-22-164-139.hsd1.wa.comcast.net [24.22.164.139])
	(authenticated authid=lentracy)
	by smtp.washington.edu (8.13.5+UW05.10/8.13.5+UW05.09) with ESMTP id jABAHr7X009035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2005 02:17:53 -0800
Message-ID: <43746FC0.3040702@ee.washington.edu>
Date: Fri, 11 Nov 2005 02:17:36 -0800
From: Leonard Tracy <ltracy@ee.washington.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel feature question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Uwash-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Since some point in the 2.6.12 kernel there has been a 
no_timer_check option available to amd64 users to solve a bug which 
causes the kernel clock on some athlon 64 system to run at 2x speed.  I 
was wondering if it was possible to get this implemented in the i386 
architecture too.  The code is rather simple and only requires something 
like 10 lines of code to be added to the io_apic.c file, however it is a 
pain to add it to every upgrade that becomes available.  Who should I 
ask to get this included as a standard?

Leonard Tracy

