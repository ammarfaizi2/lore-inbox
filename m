Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbTEXUJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEXUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 16:09:43 -0400
Received: from smtp.wp.pl ([212.77.101.161]:30891 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264130AbTEXUJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 16:09:42 -0400
Date: Sat, 24 May 2003 22:22:45 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [isdn] avm fritz pci
Message-Id: <20030524222245.5a61eae9.rmrmg@wp.pl>
In-Reply-To: <Pine.LNX.4.50.0305241504100.2267-100000@montezuma.mastecende.com>
References: <20030519134546.4c4395bf.rmrmg@wp.pl>
	<20030524082545.2d1cbdc2.rmrmg@wp.pl>
	<3ECF8559.5050209@gmx.net>
	<20030524193144.34dcd6b4.rmrmg@wp.pl>
	<3ECFBD82.60503@gmx.net>
	<Pine.LNX.4.50.0305241504100.2267-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin Zwane Mwaikambo <zwane@linuxpower.ca> quote:

> > It will be compiled in automatically if you select
> > "Local APIC Support on Uniprocessors" and "IO-APIC support on
> > uniprocessors", then boot with
> > nmi_watchdog=1
> 
> He'd have more luck with nmi_watchdog=2 on UP (not a lot of UP 
> motherboards have IOAPICs)

[root@slack:~#] dmesg | less
Kernel command line: vga=791 hdc=ide-scsi nmi_watchdog=2 
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled

my motherboard is aopen ax59pro
SysRq and NMI doesn't works
system crash after start download when use 2channel connection

-- 
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji
