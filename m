Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTLXPwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTLXPwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:52:14 -0500
Received: from www3.mail.lycos.com ([209.202.220.160]:48601 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263310AbTLXPwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:52:13 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 24 Dec 2003 10:52:10 -0500
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <BCLLEMEMOFNOFJAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: undefined reference error
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pretty out of the place I am, and beg your pardon. I have modified my kernel 2.6.0 with few new functions in fs/kernthread.c, which required a header file linux/kernthread.h.

On compilation, I get this error:

fs/built-in.o(.text+0x242f1): In function 'stop_kernthread' :
 : undefined reference to 'lock_kernel'
make: ***[.tmp_vmlinux1] Error 1

Could someone help me out with this.
Thanks in advance.

Sumit


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
