Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSLBFlX>; Mon, 2 Dec 2002 00:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSLBFlX>; Mon, 2 Dec 2002 00:41:23 -0500
Received: from sccimhc02.insightbb.com ([63.240.76.164]:52454 "EHLO
	sccimhc02.insightbb.com") by vger.kernel.org with ESMTP
	id <S264943AbSLBFlW> convert rfc822-to-8bit; Mon, 2 Dec 2002 00:41:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Steve Snyder <nobody@spamcop.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.20 eepro100 driver: Becker's or Intel's?
Date: Mon, 2 Dec 2002 00:48:47 -0500
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212020048.47178.nobody@spamcop.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an Intel 82559-based NIC (integrated into my Supermicro P4DC6+ 
motherboard) on which I'm running kernel v2.4.20.  Which of the 2 
available drivers, Becker's or Intel's, for this chipset should I run 
with this kernel?

In prior kernel versions I've used Becker's drivers and have experienced 
no problems.  Now Intel's driver is included in 2.4.20.  I've read the 
included doc (e100.txt), but neither it nor the Configure documentation 
suggest a reason to use one driver or another.  I understand that the 
Intel drivers have a feature that allows reduced CPU use at the expense 
of responsiveness, but that's all I know.

Any advice on why I should prefer one driver over the other?

Thanks.

