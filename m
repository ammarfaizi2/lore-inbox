Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFZNGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFZNGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:06:09 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:48850 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261245AbTFZNGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:06:05 -0400
Message-ID: <3EFAF2E7.1050906@free.fr>
Date: Thu, 26 Jun 2003 15:19:35 +0200
From: Fabrice Bellard <fabrice.bellard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] QEMU 0.4 release
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The QEMU x86 CPU emulator version 0.4 is available at
http://bellard.org/qemu. QEMU can now launch an unpatched(*) Linux
kernel and give correct execution performances by using dynamic
compilation.

QEMU requires no host kernel patches and no special priviledge in order
to run a Linux kernel. QEMU simulates a serial console and a NE2000
network adapter. X11 applications such as xterm have been launched.

QEMU can be used for example for faster kernel testing/debuging and
virtual hosting.

Enjoy!

Fabrice.

(*) Two bytes must be changed in order to remap the kernel at user
addresses.


