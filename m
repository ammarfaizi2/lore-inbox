Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVCEK7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVCEK7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVCEK7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:59:34 -0500
Received: from bay10-f14.bay10.hotmail.com ([64.4.37.14]:25302 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263028AbVCEK6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:58:25 -0500
Message-ID: <BAY10-F149DDACF5CCB13E7B1DED1D65D0@phx.gbl>
X-Originating-IP: [61.247.248.252]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Insmod  error ip_nat_ftp
Date: Sat, 05 Mar 2005 16:28:24 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 05 Mar 2005 10:58:24.0664 (UTC) FILETIME=[40C61980:01C52172]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai all,

When Iam giving command modprobe
I got the error
bash-2.05a# modprobe ip_nat_ftp

/sbin/insmod /lib/modules/2.4.29/kernel/net/ipv4unable to load module 
ip_conntrack_ftp

/netfilter/ip_naip_nat_ftp: error registering helper for port 21

t_ftp.o

Using /lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o

Symbol version prefix ''

/lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o: init_module: 
Device or resource busy

Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.

      You may find more information in syslog or the output from dmesg

/lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o: insmod 
/lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o failed

/lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o: insmod 
ip_nat_ftp failed

bash-2.05a#

can any one help me out where I was wrong?

Thanks in advance

regards,
Raju

_________________________________________________________________
Meet your life partner on BharatMatrimony.com 
http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Join FREE!

