Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWBBP5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWBBP5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWBBP5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:57:21 -0500
Received: from mail.asdfg.lv ([83.136.139.133]:30358 "HELO mail.asdfg.lv")
	by vger.kernel.org with SMTP id S932089AbWBBP5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:57:21 -0500
X-Antivirus-ASDFG-Mail-From: waters@inbox.lv via mail
X-Antivirus-ASDFG: 1.24-st-qms (Clear:RC:1(10.10.200.230):. Processed in 0.045062 secs Process 31055)
Date: Thu, 2 Feb 2006 17:55:30 +0200
From: kasp <waters@inbox.lv>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: kasp <waters@inbox.lv>
X-Priority: 3 (Normal)
Message-ID: <12329232343.20060202175530@inbox.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: DEVICE POLLING
In-Reply-To: <1138891187.9861.7.camel@localhost.localdomain>
References: <293455779.20060202104554@inbox.lv>
 <1138891187.9861.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Thursday, February 2, 2006, 4:39:47 PM, you wrote:

>> I've read that *BSD like systems support device polling:
>> So, are there any feature like that in linux kernel supported?

AC> The Linux kernel does similar things for high network loads. Some serial
AC> hardware also supports that functionality (eg comtrol rocketport).

Should I turn this feature somewhere on, or is it already enabled by default?
I'm using Intel PRO/100 network cards if it's important.

-- 
Best regards,
 kasp                            mailto:waters@inbox.lv

