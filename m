Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTDWNDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTDWNDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:03:19 -0400
Received: from [203.197.168.150] ([203.197.168.150]:53004 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S264021AbTDWNDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:03:19 -0400
Message-ID: <3EA69279.F14467F9@tataelxsi.co.in>
Date: Wed, 23 Apr 2003 18:47:45 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: setting LAA
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I was trying to set the LAA through the familiar command of
"ifconfig tr hw tr 4000deadbeef" but is is giving SIOCSHWADDR: Invalid
argument.

While going through the ifconfig manpage, I found that the hw classes
supported are ether, ax25, ARCnet and netcom.
"tr" is not mentioned.

Is it that setting of LAA in token ring is dispensed from the 2.4
kernels. If it is not, is there any patch for it?
Can someone please send me the patch as I tried in the net with no
success

Thanks & Refgards
Prasanta


