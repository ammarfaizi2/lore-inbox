Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJDNvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJDNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:51:54 -0400
Received: from msdo0001.xtend.de ([217.27.0.68]:29349 "EHLO msdo0001.xtend.de")
	by vger.kernel.org with ESMTP id S262037AbTJDNvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:51:53 -0400
Message-ID: <3F7ED071.7080005@triaton-webhosting.com>
Date: Sat, 04 Oct 2003 15:51:45 +0200
From: Georg Chini <georg.chini@triaton-webhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:1.4a) Gecko/20030510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sparc32 - sched_clock missing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there,

tried to build Kernel 2.6.0-test6-bk4 on my
sparc32 machine and found that the function
sched_clock is missing in time.c. Can anyone
tell me what I have to put there? Please CC
to me.


Thanks in advance
                  Georg Chini

