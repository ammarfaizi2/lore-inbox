Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVJDPza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVJDPza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVJDPza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:55:30 -0400
Received: from web35909.mail.mud.yahoo.com ([66.163.179.193]:37500 "HELO
	web35909.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964827AbVJDPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:55:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W76qHuPTAHl1LEFz3cd156tx80D0JjdPmy+npim30ILOPdIKaIdaKWGAb3C2s+0YO7TdUbQj+ZcTkpoM8xa1IrJaFviWs/oPAq1JJsHw4ys6zMZHW4WMH/O6Abv3R/R8EJBrVA2A+TMl7kAcpHPuDvUa5EEFPCz662OtvzYM1hI=  ;
Message-ID: <20051004155529.88324.qmail@web35909.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 08:55:29 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: error during compiling kernel  2.6.10 on FC3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
    I am compiling kernel 2.6.10 on FC3 as usual 
using following steps  

1) make Menuconfig
2) make bzImage
3) make modules
4) make modules_install

        But in 4 th step i got error after some moules

are installed

Error Message  is like this
if [ -r System.map ]; then /sbin/depmod -ae -F
System.map  2.6.10; fi /bin/sh: line 1: 11366
Terminated              /sbin/depmod -ae -F System.map
2.6.10
make: *** [_modinst_post] Error 143

     I also want to know what no 143 indicates.

What should i do. How to overcome this error 


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
