Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbRGRQyd>; Wed, 18 Jul 2001 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRGRQyX>; Wed, 18 Jul 2001 12:54:23 -0400
Received: from f79.law3.hotmail.com ([209.185.241.79]:61961 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267908AbRGRQyM>;
	Wed, 18 Jul 2001 12:54:12 -0400
X-Originating-IP: [24.18.79.48]
From: "Carl Husa" <carlhusa@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Custom Kernel & NICS
Date: Wed, 18 Jul 2001 16:54:11 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F79nNAR1JBjbUf9Sp2W00000c7b@hotmail.com>
X-OriginalArrivalTime: 18 Jul 2001 16:54:11.0378 (UTC) FILETIME=[44A7A920:01C10FAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have installed RedHat Linux 7.1, kernel 2.4.2 with two NICs - 3COM905cx and 
NetGear FA311. Box will be used as a firewall to separate two rfc 1918 - 
networks 10.0.0.0 and 192.168.1.0.

At completion of initial install. both NIC's are recognized, activated and 
load (lsmod shows natsemi and 3c59x). Can connect to Internet from exteernal 
address, can ping both interfaces.

Then I Customize kernel, with support for iptables, NAT/MASQ, netfilter. 
Compile is successful, boot is successful, BUT - neither NIC activates. 
Otherwise, boot is fine, the cat test for iptables produces a '1'.

What am I doing wrong?
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

