Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUBHAAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBHAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:00:19 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:64896 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261500AbUBHAAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:00:16 -0500
Message-Id: <5.1.0.14.2.20040208105611.04710418@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 08 Feb 2004 11:00:10 +1100
To: JG <jg@cms.ac>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040207182648.080C31A93BB@23.cms.ac>
References: <5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
 <20040125123154.A8CA4202CAA@23.cms.ac>
 <20040122125516.7B671202CDC@23.cms.ac>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <20040119033527.GA11493@linux.comp>
 <20040119033527.GA11493@linux.comp>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
 <20040122125516.7B671202CDC@23.cms.ac>
 <5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
 <20040125123154.A8CA4202CAA@23.cms.ac>
 <5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:26 AM 8/02/2004, JG wrote:
>just wanted to report, that it wasn't the cable or the tg3 driver but a 
>defective NIC. i switched to a card with a realtek 8169 chipset and now it 
>looks muuuuch better ;) and the best thing, no errors in ifconfig.

good to hear.
what revision BCM5700 was it that you had?

i've heard reports that the newer BCM5705s have 'issues' whereas 
BCM5700-5703 are good.

can you post your 'lspci -vvv' output?


cheers,

lincoln.

