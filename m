Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUAIBli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUAIBli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:41:38 -0500
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:12512 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S266409AbUAIBkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:40:52 -0500
Message-ID: <3FFE078D.20400@metrowerks.com>
Date: Fri, 09 Jan 2004 02:44:45 +0100
From: Bernhard Kuhn <bkuhn@metrowerks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [announcement, patch] real-time interrupts for the Linux kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody!

I hope that i can steal enough of your precious time to get
your attention for a new patch that adds hard real time support
to the linux kernel (worst case interrupt response time below
5 microseconds):

The proposed "real time interrupt patch" enables the linux
kernel for hard-real-time applications such as data aquisition
and control loops by adding priorities to interrupts and spinlocks.

The following document will describe the patch in detail and how
to install it:

http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/README


The patch and a demo application can be downloaded from:

http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/rtirq-20040108.tgz


Comments are highly appreciated!


best regards

Bernhard Kuhn, Senior Software Engineer, Metrowerks












