Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266726AbUGLFnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266726AbUGLFnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266728AbUGLFnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:43:01 -0400
Received: from netsonic.fi ([194.29.192.20]:60358 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id S266726AbUGLFnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:43:00 -0400
Message-ID: <40F224DE.1060902@netsonic.fi>
Date: Mon, 12 Jul 2004 08:42:54 +0300
From: Markus Kovero <markus.kovero@netsonic.fi>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: c-d.hailfinger.kernel.2004@gmx.net
Subject: Problems with nforce3 nic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I recently bought SN85G4 shuttle which has small mobo with nforce3 
on it. Integrated audio and nic.
audio works fine and nic gots regonized but doesnt work very well, link 
falls every now and then and whines about irq being lost and its totally 
unusable. Linux kernel version iam using is 2.6.7
It would be very critical to get this driver working because shuttle 
mobo has just one pci slot :-p (=one extra nic).
Is this known issue or do you want some debug info?

Markus Kovero
