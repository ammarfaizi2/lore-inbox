Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTINB26 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 21:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbTINB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 21:28:57 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:8172 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262275AbTINB25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 21:28:57 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: linux-kernel@vger.kernel.org
Subject: logging when SIGSEGV is processed?
Date: Sun, 14 Sep 2003 03:28:54 +0200
User-Agent: KMail/1.5.3
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309140328.54920.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found this patch for kernel 2.2 which logs a message when some process 
receives SIGSEGV. Imho something very usefull: I could create some script 
which sends an e-mail if some critical (apache, mysql, etc.) process 
segfaults. I was wondering: has anyone ported this patch to 2.4 or 2.6? 


Folkert van Heusden

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

