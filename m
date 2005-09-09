Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVIILWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVIILWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVIILWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:22:51 -0400
Received: from mxout1.vodatel.hr ([217.14.208.62]:51845 "EHLO
	mxout1.vodatel.hr") by vger.kernel.org with ESMTP id S1030246AbVIILWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:22:50 -0400
Message-ID: <43217233.30206@vodatel.hr>
Date: Fri, 09 Sep 2005 13:29:55 +0200
From: Vedran Rodic <vedran@vodatel.hr>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-dvb@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13 reboot problems (when skystar2 DVB driver inserted)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm using 2.6.13 on my computer with skystar2, b2c2-flexcop driver.

If the driver is inserted into kernel, the reboot won't work.

It just hangs at "Rebooting..."

Can I get any help in debugging these reboot problems?

I've put dmesg and lspci output at 
http://gargamel.vodatel.hr/~vedran/kernel/


Thank you

Vedran Rodic
