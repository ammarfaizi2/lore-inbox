Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFPM7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFPM7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:59:14 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:38301 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263859AbTFPM7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:59:13 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Reminder: 2.4.* generic HDLC patches
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 16 Jun 2003 15:13:01 +0200
Message-ID: <m3u1aq17z6.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The generic HDLC patches for 2.4 kernels are here:

a) for linux-2.4.21:
   ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch
   or
   http://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch

b) for linux-2.4.21-ac1:
   ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre5-ac3-1.14.patch
   or
   http://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre5-ac3-1.14.patch


Linux-2.5 already contains this patch. Tested, no ABI changes, etc.
Please apply. Thanks.
-- 
Krzysztof Halasa
Network Administrator
