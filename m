Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTLORSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLORSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:18:44 -0500
Received: from [212.103.193.198] ([212.103.193.198]:1030 "EHLO mail.ost.lan")
	by vger.kernel.org with ESMTP id S263702AbTLORSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:18:39 -0500
Message-ID: <3FDDED35.6090609@ost.it>
Date: Mon, 15 Dec 2003 18:19:49 +0100
From: Marco Trevisan <trevisan@ost.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: it, en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sata_via broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm experiencing problems in having the vt8237 S-ATA controller working 
properly on my board (MSI KT6-Delta).
I'm running 2.6.0-test11-bk10 (distro: Debian 'testing').
After browsing the list archive, I found something about this problem 
(threads: "SATA and 2.6.0-test9"and "Linux 2.6.0-test9"), but no solution...
I then surfed the net and it seems that there is a patch for 2.4.22 
kernels (I don't know wether it works or not).

So my questions are:
1) is this issue to be resolved shortly in 2.6.0-testX ?
2) Which SATA PCI controller is known to work properly under 2.6.0-test11 ?

The machine is currently under testing, so I can try experimental 
patches if it can help the process.

Thanks in advance for any reply.

    Marco Trevisan


