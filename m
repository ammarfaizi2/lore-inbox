Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTJOXzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJOXzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:55:23 -0400
Received: from host42-162.pool81113.interbusiness.it ([81.113.162.42]:3200
	"EHLO matrix") by vger.kernel.org with ESMTP id S262572AbTJOXzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:55:22 -0400
From: Frederik Nosi <fredi@e-salute.it>
To: linux-kernel@vger.kernel.org
Subject: Hangs with 2.4.23-preX kernels =?iso-8859-1?q?probab=F2y=20related=20to=20the=208139cp?= driver
Date: Thu, 16 Oct 2003 02:01:50 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310160201.50839.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm experiencing hangs with 2.4.23-pre kernels when using the network with 
the said driver. The last kernel that works is the 2.4.22-pre8. I noticed 
that during this versions there where updates to the eth. drivers. 
Unfortunately the kernel does not give any error, just the pc does not 
respond to pings, the cursor on screen stops blinking. Tried with sysrq 
enabled too but nothing on logs. I can reliabily reproduce this just doing 
something network intensive, eg. accessing a remote desktop during a full 
kernel download ;)
Sorry for this terse info, if you need any other info just ask. And please CC 
me on replies as I'm not subscribed to the list.

Thanks,
Fredi
