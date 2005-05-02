Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVEBKPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVEBKPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 06:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEBKPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 06:15:00 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:35077 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S261187AbVEBKO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 06:14:59 -0400
Message-ID: <24078.194.237.142.10.1115028893.squirrel@194.237.142.10>
In-Reply-To: <Pine.LNX.4.62.0505021148100.15343@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0505021148100.15343@jjulnx.backbone.dif.dk>
Date: Mon, 2 May 2005 12:14:53 +0200 (CEST)
Subject: Re: kconfig: trying to assign nonexistent symbol (2.6.12-rc3-mm2)
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Jesper Juhl" <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> scripts/kconfig/mconf arch/i386/Kconfig
> #
> # using defaults found in arch/i386/defconfig
> #
> arch/i386/defconfig:174: trying to assign nonexistent symbol
> PCI_USE_VECTOR
> arch/i386/defconfig:219: trying to assign nonexistent symbol
> PARPORT_PC_CML1
> arch/i386/defconfig:223: trying to assign nonexistent symbol PARPORT_OTHER

Just a sign that defconfig is a bit outdated.

   Sam

