Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTFMHme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTFMHme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:42:34 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:41879 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265226AbTFMHmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:42:33 -0400
From: "Andreas Achtzehn" <linux-kernel@achtzehn.homelinux.org>
To: <linux-kernel@vger.kernel.org>
Subject: AW: [OOPS] immediate reboot w/ compiled in CONFIG_FILTER, CONFIG_PPPOE,CONFIG_PPP
Date: Fri, 13 Jun 2003 09:56:07 +0200
Message-ID: <EMEAKOPCBDOCHKHEEBCGGEDBCDAA.linux-kernel@achtzehn.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <EMEAKOPCBDOCHKHEEBCGAEDBCDAA.linux-kernel@achtzehn.homelinux.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.10; AVE: 6.20.0.0; VDF: 6.20.0.8; host: achtzehn.homelinux.org)
X-Seen: false
X-ID: TzguHeZrQeTOiNskt67-zwiA7snYP+ejmBI8nIjWuvuvkk0rHAAi49@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Andreas Achtzehn [mailto:linux-kernel@achtzehn.homelinux.org]

> following default config causes the kernel to reboot immediately 
> after having been uncompressed by lilo. No message after "loading 
> linux...." is shown.
> 
kernel is 2.4.21-rc8.
