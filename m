Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWGMK7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWGMK7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWGMK7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:59:08 -0400
Received: from ip-140-150.sn2.eutelia.it ([83.211.140.150]:13755 "HELO
	intranet.antek.it") by vger.kernel.org with SMTP id S1751360AbWGMK7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:59:06 -0400
Message-ID: <44B6279E.6060002@antek.it>
Date: Thu, 13 Jul 2006 12:59:42 +0200
From: Luca Ognibene <ognibene@antek.it>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pcmcia card not recognized with 2.6.18-rc1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a "Onda N501HS" umts/gprs pcmcia card. I've attached it to the pci
bus using a pci<->pcmcia card.
I've tested with two kernels, 2.6.8 (from debian sarge) and 2.6.18-rc1
(compiled). Both kernels can't recognize the card at the boot time, only
the debian kernel can recognize it if i remove/reinsert it while the
system is running.

Logs from 2.6.18-rc1: http://people.freedesktop.org/~skaboy/USB-2.6.18-rc1

Logs from 2.6.8 (debian sarge):
http://people.freedesktop.org/~skaboy/USB-2.6.8-debian

Motherboard: SiS-661
Distro: debian sarge

Tell me if you need more info/debug.

ciao
Luca
