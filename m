Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRJHNvc>; Mon, 8 Oct 2001 09:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276897AbRJHNvW>; Mon, 8 Oct 2001 09:51:22 -0400
Received: from [200.248.92.2] ([200.248.92.2]:59660 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S276894AbRJHNvT>; Mon, 8 Oct 2001 09:51:19 -0400
Message-Id: <200110081353.LAA11233@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: linux-kernel@vger.kernel.org
Subject: EMC SYMMETRIX multiple LUN's
Date: Mon, 8 Oct 2001 10:50:08 -0300
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011004020550.A1271@willy.wsc.edu>
In-Reply-To: <20011004020550.A1271@willy.wsc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I testing DELL 8450 under Linux, and kernel probe only two LUN's from EMC, 0 
and 1, but I have 2 and 254, if  I use scsi add-single-device to this other 
LUN's, works perfect. I try to set max_scsi_luns, has the same results.

I test with kernel 2.4.9, 2.4.10-ac7, both have the same problem.

With Conectiva Linux Kernel 2.4.5-9cl, he show all LUNS, work fine!

Any Help?


Thank's




Andre
