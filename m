Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUL3BvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUL3BvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUL3BvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:51:24 -0500
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:52623 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261504AbUL3BvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:51:22 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200412300147.iBU1lIen022398@wildsau.enemy.org>
Subject: Re: disabling IRQs cause nobody cares (incl. oops)
In-Reply-To: <200412300019.iBU0JYgr022375@wildsau.enemy.org>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Date: Thu, 30 Dec 2004 02:47:18 +0100 (MET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> good evening,
> 
> anyone knows what's the cause of this:
> 
> Dec 30 01:13:45 burn kernel: irq 19: nobody cared!

okidok.... seems to be related to CONFIG_PREEMPT.

so, whoever is interested in fixing CONFIG_PREEMPT, I
can provide a test machine which can trigger this error
pretty fast.

regards,
Herbert Rosmanith

