Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbTHaPz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTHaPz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:55:28 -0400
Received: from luli.rootdir.de ([213.133.108.222]:46982 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S262208AbTHaPzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:55:25 -0400
Date: Sun, 31 Aug 2003 17:55:22 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.22: APM Power-Off does not work
Message-ID: <20030831155522.GA1277@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Wed Sep  3 17:50:47 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test4-mm4 i686
X-No-archive: yes
X-Uptime: 17:50:47 up  1:17,  4 users,  load average: 0.07, 0.12, 0.07
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


Kernel 2.4.22 does not power of my HP omnibook 4150B (APM Bios 3.13)
(http://h20004.www2.hp.com/soar_rnotes/bsdmatrix/matrix31635en_US.html#BIOS).
With Kernel 2.6.0-test4-mm4 it works, but there suspend to disk does not
work any more.

I tried with CONFIG_APM_REAL_MODE_POWER_OFF and without. The machine
does not power off. It just stops after saying "Power off". When I press
ctrl-alt-del afterwards, the kernel crashes in both cases.

Is there a patch for 2.4.22 around?


Regards, claas

