Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUIKN3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUIKN3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUIKN3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:29:17 -0400
Received: from eri.interia.pl ([217.74.65.138]:47502 "EHLO eri.interia.pl")
	by vger.kernel.org with ESMTP id S268146AbUIKN3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:29:16 -0400
Message-ID: <4142FDA8.90508@interia.pl>
Date: Sat, 11 Sep 2004 15:29:12 +0200
From: =?ISO-8859-2?Q?Marcin_G=B3ogowski?= <marcin.glogowski@interia.pl>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with booting my kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: e1204acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
I have strange problem: Im using the 2.4.21 version of Linux kernel 
which is patched to be usable with the cirrus (arm) machines.
Everything looks good, but when the system is booting kernel stops after 
"TCP hash tables configured" message.
Any kernel panic message nor other info is displayed.
I would be grateful if somebody would tell me which file of the linux 
kernel (or part of the kernel) is next after the TCP initialization.
I will try to change the files in the linux kernel, but I dont know for 
now which.
I think it could be the multicast, but Im not sure.
Thank You for help, regards
Marcin Glogowski

----------------------------------------------------------------------
Startuj z INTERIA.PL!!! >>> http://link.interia.pl/f1830

