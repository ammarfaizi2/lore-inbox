Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSGTLCc>; Sat, 20 Jul 2002 07:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGTLCc>; Sat, 20 Jul 2002 07:02:32 -0400
Received: from mkc-65-26-127-29.kc.rr.com ([65.26.127.29]:29703 "EHLO
	portal.home.hanaden.com") by vger.kernel.org with ESMTP
	id <S315468AbSGTLCb>; Sat, 20 Jul 2002 07:02:31 -0400
Message-ID: <3D394409.2010906@hanaden.com>
Date: Sat, 20 Jul 2002 06:05:45 -0500
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: howto Name eth[0 .. n-1]  in kernel 2.4.18 vs earlier kernels?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded to 2.4.18 on debian woody and built my own kernel.  In the
past, there was an alias for "tulip" in the modules file.  This named my
NIC eth0.  In my firewall, it named the NICs eth0 and eth1

In 2.4.18 I cannot seem to find the place to name the NICs.  Where can
this be done?  It will be a big issue on my firewall as eth0 MUST remain
the external nic.

Thankyou


