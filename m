Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUAQWrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 17:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUAQWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 17:47:45 -0500
Received: from [66.50.163.253] ([66.50.163.253]:48444 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266165AbUAQWro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 17:47:44 -0500
Message-ID: <4009BB8C.50107@computingsupport.org>
Date: Sat, 17 Jan 2004 18:47:40 -0400
From: Rafael Fernandez <rafael@computingsupport.org>
User-Agent: Mozilla Thunderbird 0.5a (X11/20040115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.1: Sidewinder Precision 2 not working 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I once used the Sidewinder Precision 2 joystick in kernel 2.4.22 but the 
calibration wasn't any good. I just thought to give it a try in the 
2.6.1 kernel, I loaded the module, modprobe sidewinder without any 
errors. Yet, when I run FlighGear with fgfs --control=joystick or with 
just fgfs I can't use it. I don't know if this is a kernel bug, but I 
though it might be worth posting it.

Rafael Fernandez
