Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWI3Vit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWI3Vit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWI3Vit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:38:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:1499 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751983AbWI3Vis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:38:48 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <451EE36C.5080002@s5r6.in-berlin.de>
Date: Sat, 30 Sep 2006 23:36:44 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: Randy Dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com> <20060930123547.d055383f.rdunlap@xenotime.net>
In-Reply-To: <20060930123547.d055383f.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
>> patching file drivers/lcddisplay/cfag12864b.c
...

What does the D in LCD stand for? I suggest this is named
drivers/lcdisplay/ instead.
-- 
Stefan Richter
-=====-=-==- =--= ====-
http://arcgraph.de/sr/
