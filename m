Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVGLQiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVGLQiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVGLQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:36:20 -0400
Received: from mx2.go2.pl ([193.17.41.42]:2732 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S261572AbVGLQeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:34:14 -0400
From: vacant2005@o2.pl
To: linux-kernel@vger.kernel.org
Subject: system.map
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 12 Jul 2005 18:34:49 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507121834.50084.vacant2005@o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After compiling new kernel, it doesn`t load System.map file. In kernel 
messages I can find:

Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
notenabled.

I have support for modules compiled.
I add config file of my kenrel.
http://sniffergg.port5.com/config.txt

uname -a shows

conexion1:~# uname -a
Linux conexion1 2.6.12-cko2nexus #1 Fri Jul 8 18:24:04 CEST 2005 i686 
GNU/Linux

I installed kernel using command installkernel

conexion1:~# installkernel
Usage: installkernel <version> <zImage> <System.map> <directory>


to make sure that System.map file will match the kernel version. 

Please help me,
Jacek Jablonski
