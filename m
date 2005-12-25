Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVLYPSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVLYPSS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 10:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVLYPSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 10:18:18 -0500
Received: from tag.witbe.net ([81.88.96.48]:10886 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1750841AbVLYPSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 10:18:18 -0500
Message-Id: <200512251517.jBPFH8D17229@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Date: Sun, 25 Dec 2005 16:17:11 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcYHZvXjL52sldsVR9Wiea/CdNp0QQB/yg8w
In-Reply-To: <43AB5E12.5050208@pobox.com>
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RHES3 doesn't support kernel 2.6.
> 
> Kernel 2.6.x will boot just fine, on RHEL3 userland.
> 
> It is not -supported- in the commercial sense, however.

Yes, but I don't intend to ask RH for any support on a 2.6 vanilla
kernel on top of a RHES3 distro. ;)

I've installed 2.6.14.4, and it is really nice to have all this
running fine, both SATA and PATA connected to the same controler.

Regards,
Paul

