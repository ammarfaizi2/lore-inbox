Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWHNMQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWHNMQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWHNMQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:16:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55186 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752018AbWHNMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:16:04 -0400
Subject: Re: HT not active
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Aug 2006 13:36:24 +0100
Message-Id: <1155558984.24077.191.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-14 am 13:38 +0200, ysgrifennodd Jan Engelhardt:
> What could be missing? Some BIOS option perhaps?
> Thanks for any hints.

Hyperthreading must be BIOS enabled, its not something Linux can "turn
on". The "ht" flag merely indicates that the processor supports
hyperthreading not that it is enabled.

