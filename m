Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUAHQSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUAHQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:18:32 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:39599 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S265369AbUAHQSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:18:31 -0500
Message-ID: <3FFD82E2.7090105@gmx.de>
Date: Thu, 08 Jan 2004 17:18:42 +0100
From: Alwin Meschede <ameschede@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031231 Debian/1.5-3
X-Accept-Language: de-de, de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Numbersign key dysfunctional in 2.6.1-rc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

until kernel version 2.6.1-rc1, the numbersign/tilde key on my Logitech 
USB keyboard used to generate the scancode 0x2b. Under 2.6.1-rc1 and 
newer versions, it generates 0x54, which I suppose to collide with SysRQ 
or something like that (I found some information indicating this in 
http://www.ussg.iu.edu/hypermail/linux/kernel/0003.2/0721.html ). As 
result, the numbersign key causes things like switching from one console 
to another instead of printing a numbersign...

Alwin Meschede

