Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUHFQJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUHFQJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268171AbUHFQHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:07:10 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:26280 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S268166AbUHFQFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:05:49 -0400
From: andreamrl <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: linux-kernel@vger.kernel.org
Subject: New wlan kernel driver (rtl8180+sa2400)
Date: Fri, 6 Aug 2004 16:13:14 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061613.14779.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm writing a module for linux kernel in the hope to make work cards with 
Realtek rtl8180 main chip and philips sa2400 radio chip.
Altought it is still in an early development stage I decided to announce it 
because it now roughly reiceves and transmits frames (at least on my system).
It is bad written and for now it still lack of ceratin fundamental thing 
(memory freeing etc..).. 
If someone is interested it is on sourceforge named rtl8180-sa2400.
I hope this may be useful to someone, if not sorry in advance..

Thanks,
Andrea Merello
