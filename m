Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWICOQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWICOQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 10:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWICOQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 10:16:34 -0400
Received: from helium.samage.net ([83.149.67.129]:17584 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1751166AbWICOQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 10:16:33 -0400
Message-ID: <4947.81.207.0.53.1157292958.squirrel@81.207.0.53>
In-Reply-To: <200609031251.23743.rjw@sisk.pl>
References: <200609031251.23743.rjw@sisk.pl>
Date: Sun, 3 Sep 2006 16:15:58 +0200 (CEST)
Subject: Re: Q: Suspend/resume support for sata_sil
From: "Indan Zupancic" <indan@nul.nu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Jeff Garzik" <jeff@garzik.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "LKML" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, September 3, 2006 12:51, Rafael J. Wysocki said:
> Hi,
>
> Could you please tell me if suspend/resume is supported by the sata_sil driver?

Works for me with suspend to ram, and there seem to be plenty suspend/resume functions in
drivers/scsi/sata_sil.c, so I guess it is.

Greetings,

Indan



-- 
VGER BF report: H 0.0826158
