Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTFHUmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFHUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 16:42:33 -0400
Received: from parmenides.zen.co.uk ([212.23.8.69]:1554 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP id S263782AbTFHUmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 16:42:32 -0400
X-Zen-Trace: 217.155.152.69
Message-ID: <000501c32e00$85d4f670$8200a8c0@coolermaster>
From: "Peter Westwood" <peter.westwood@talk21.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Date: Sun, 8 Jun 2003 21:57:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In a similar vein to the Linksys router.  I have a Buffalo (Melco) WBR-G54.

Looking through the latest firmware update available :
http://www.buffalo-technology.com/support/firmware.htm

It does appear to be similar to the Linksys firmware and contain linux and
possibly busybox

No mention here or anywhere on there site of the GPL or the source code to
what they are distributing!

Unfortunately an nmap scan only shows the following ports open:

Starting nmap V. 3.00 ( www.insecure.org/nmap )
Interesting ports on  (192.168.0.1):
(The 1597 ports scanned but not shown below are in state: closed)
Port       State       Service
53/tcp     open        domain
80/tcp     open        http
2601/tcp   open        zebra
2602/tcp   open        ripd
Remote operating system guess: Linux Kernel 2.4.0 - 2.5.20
Uptime 1.252 days (since Sat Jun 07 15:51:52 2003)
Nmap run completed -- 1 IP address (1 host up) scanned in 13 seconds

No telnet or ssh for me to try to discover more.

--
Peter

