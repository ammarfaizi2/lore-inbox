Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGNBoP>; Sat, 13 Jul 2002 21:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSGNBoO>; Sat, 13 Jul 2002 21:44:14 -0400
Received: from mkc-65-26-127-29.kc.rr.com ([65.26.127.29]:22536 "EHLO
	portal.home.hanaden.com") by vger.kernel.org with ESMTP
	id <S315539AbSGNBoN>; Sat, 13 Jul 2002 21:44:13 -0400
Message-ID: <3D30D81B.8000809@hanaden.com>
Date: Sat, 13 Jul 2002 20:47:07 -0500
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.18 panic on orinoco null event
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help please?!?  The wireless card in my laptop + its driver is causing a
kernel panic.

HW:
	laptop with built-in 802.11b card
	P4 1.7
OS:
	Debian Woody & kernel 2.4.18

running dhclient-2-2-x causes the following error:

Unable to handle kernel NULL ponter dereference at virtual
address 0000 0078
Tainted: P
Kernel panic: killing interrupt handler!
eth1: Null event in orinoco_interrupt!

Thank you.


