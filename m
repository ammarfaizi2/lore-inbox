Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbRGMLgp>; Fri, 13 Jul 2001 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267046AbRGMLgh>; Fri, 13 Jul 2001 07:36:37 -0400
Received: from [212.124.67.194] ([212.124.67.194]:11392 "EHLO
	ns.globaltech-bg.com") by vger.kernel.org with ESMTP
	id <S267042AbRGMLgW>; Fri, 13 Jul 2001 07:36:22 -0400
From: "Todor" <tbelev@globaltech-bg.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.6 problem with iptables 
Date: Fri, 13 Jul 2001 14:36:21 +0300
Message-ID: <000601c10b90$09febc50$600ba8c0@int.globaltechbg.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 
Before 2 hours I Have a good working 2.4.4 with custom Firewall iptables
rules.
After upgrading to 2.4.6 and aplayng the same Iptables rules I'm
receiveing  many messages at kernel log:

Jul 13 12:36:45 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:36:49 ns kernel: ipt_unclean: TCP option 4 at 26 too long
Jul 13 12:36:49 ns kernel: ipt_unclean: TCP option 4 at 26 too long
Jul 13 12:36:55 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:36:55 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:09 ns kernel: ipt_unclean: TCP option 8 at 22 too long
Jul 13 12:37:09 ns kernel: ipt_unclean: TCP option 8 at 22 too long
Jul 13 12:37:10 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:10 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:15 ns kernel: ipt_unclean: TCP option 8 at 22 too long
Jul 13 12:37:15 ns kernel: ipt_unclean: TCP option 8 at 22 too long
Jul 13 12:37:16 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:16 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:25 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:25 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:26 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:26 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:35 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:35 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:36 ns kernel: ipt_unclean: TCP option 2 at 40 too long
Jul 13 12:37:36 ns kernel: ipt_unclean: TCP option 2 at 40 too long

I'm using the same configuration from the old kernel.
Please help me !!!

Thanks 
Todor Belev
System/Network Administrator
Globaltech-BG 
Sofia, Bulgaria

