Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131622AbRCURGf>; Wed, 21 Mar 2001 12:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRCURGZ>; Wed, 21 Mar 2001 12:06:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131622AbRCURGT>; Wed, 21 Mar 2001 12:06:19 -0500
Subject: Re: Alert on LAN for Linux?
To: terje.malmedal@usit.uio.no (Terje Malmedal)
Date: Wed, 21 Mar 2001 17:08:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14cvTq-0000oH-00@morgoth> from "Terje Malmedal" at Mar 13, 2001 09:33:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14fm5o-0000uT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> things correctly they have enhanced Wake-on-LAN to allow you to do
> things like reset the machine, update the BIOS and such by sending
> magic packets which are interpreted by the network card. Or maybe I am

Normally 'sending magic packets resets the machine' is considered a feature
reported to bugtraq. The alert stuff I have seen is more akin to sending SNMP
traps for things like people opening the lid, or fan failure

