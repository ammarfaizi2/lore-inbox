Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWELPez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWELPez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWELPez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:34:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:27338 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932138AbWELPey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:34:54 -0400
Date: Fri, 12 May 2006 17:34:50 +0200 (MEST)
Message-Id: <200605121534.k4CFYodu020885@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against stable kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>The following drivers support new features.
>
>ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
>sata_sil:	new EH, irq-pio, hotplug
>ahci:		new EH, irq-pio, NCQ, hotplug
>sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier

If you were to add new EH and NCQ support to sata_promise,
then I'd test it on my News server.

/Mikael
