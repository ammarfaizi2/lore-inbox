Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTIXPQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTIXPQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 11:16:51 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:6843 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S261432AbTIXPQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 11:16:50 -0400
Message-ID: <3F71B513.1000204@netscape.net>
Date: Wed, 24 Sep 2003 20:45:31 +0530
From: Adarsh Daheriya <AdarshDNet@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: dual ethernet ports problem.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 203.196.148.130
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i have got a system which has 2 eth ports. i use one of them (eth0) to 
"network boot" the system
using dhcp, tftp and then mount the nfs file system on it.

this leaves the other port (eth1) unusable. i cannot ping to the other 
system through it.
but when i ping any of the two eth ports from some other system i get 
the reply back.
but to my amazement the mac entries of both the ports is that of eth0 in 
arp table. (arp command)

why and how eth0 is acting as a proxy (perhaps) for both the ports and 
how can i disable it?

could anybody please help me in this concern.

regards,
-adarsh.

