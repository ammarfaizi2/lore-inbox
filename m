Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRDOJDv>; Sun, 15 Apr 2001 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDOJDl>; Sun, 15 Apr 2001 05:03:41 -0400
Received: from mailsrv1.dlink.com.tw ([210.66.49.71]:52240 "EHLO
	mailsrv1.dlink.com.tw") by vger.kernel.org with ESMTP
	id <S132608AbRDOJDc>; Sun, 15 Apr 2001 05:03:32 -0400
From: vivid_liou@dlink.com.tw
X-Lotus-FromDomain: D-LINK
To: linux-kernel@vger.kernel.org
Message-ID: <48256A2F.0031B489.00@dlink.com.tw>
Date: Sun, 15 Apr 2001 17:07:24 +0800
Subject: can't use printk in linux 2.4.2 module
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear All :
I wrote a small module to print "hello world " . when I comiple it under kernel
2.2 , everything works fine.
 the output " printk unsolve " appear under 2.4.2 .
with kernel 2.2. , I can find "printk " in the /proc/ksyms , but
with kernel 2.4.2  , only "printk_Rsmp" symbol .
Does anyone know how to solve the problem ?  Thanks you a lot.




