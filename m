Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVIFSvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVIFSvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIFSvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:51:35 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:17383
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750794AbVIFSve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:51:34 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <ipw2100-admin@linux.intel.com>,
       "'Roman Zippel'" <zippel@linux-m68k.org>,
       "'Sam Ravnborg'" <sam@ravnborg.org>
Subject: RE: [PATCH] wrong firmware location in IPW2100 Kconfig entry   (Was: IPW2100 Kconfig)
Date: Tue, 6 Sep 2005 12:51:26 -0600
Message-ID: <005901c5b313$fc974610$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200509062048.29495.jesper.juhl@gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Who should I send the "patch" to? Or can someone simply change that?

Jesper,

	Thanks. I also had a question. To whom is this patch sent to? Netdev or LK?
How does one determine?

.Alejandro

>
> Firmware should go into /lib/firmware, not /etc/firmware.
>
> Found by Alejandro Bonilla.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

