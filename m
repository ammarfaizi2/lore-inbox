Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWFKKZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWFKKZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWFKKZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:25:19 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37772 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751586AbWFKKZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:25:18 -0400
Date: Sun, 11 Jun 2006 12:25:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikael Pettersson <mikpe@it.uu.se>
cc: rdunlap@xenotime.net, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during
 modpost
In-Reply-To: <200606110051.k5B0pLBI010621@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.61.0606111224320.13585@yvahk01.tjqt.qr>
References: <200606110051.k5B0pLBI010621@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The messages above are from when I used gcc-4.1.1.
>With gcc-3.2.3 I only see a single warning.
>
FTR, gcc 4.0.x is also 'affected'.


Jan Engelhardt
-- 
