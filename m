Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTEXGMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTEXGMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 02:12:42 -0400
Received: from smtp.wp.pl ([212.77.101.161]:28973 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264072AbTEXGMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 02:12:41 -0400
Date: Sat, 24 May 2003 08:25:45 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [isdn] avm fritz pci
Message-Id: <20030524082545.2d1cbdc2.rmrmg@wp.pl>
In-Reply-To: <20030519134546.4c4395bf.rmrmg@wp.pl>
References: <20030519134546.4c4395bf.rmrmg@wp.pl>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin Rafa³ 'rmrmg' Roszak <rmrmg@wp.pl> quote:

> I have kernel 2.4.21-rc2  (I also tested 2.4.20 2.4.21-pre6, pre7 and
> rc1) and when I use 2 channels connect, system crash. Hisax modul is
> loaded with parametrs: 
> modprobe hisax protocol=2 type=27
> 
 
I have this problem also in 2.4.21-rc3
I compilded kernel with MAGIC_SYSRQ but I can't reboot system after
crash use Alt+PrtScr+[s,u,b] ...

-- 
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji
