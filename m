Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULMU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULMU6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULMU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:58:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5268 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261326AbULMU5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:57:41 -0500
Date: Mon, 13 Dec 2004 21:57:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Typo in kernel configuration (xconfig)
In-Reply-To: <Pine.LNX.4.61.0412132059290.3382@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412132156590.30655@yvahk01.tjqt.qr>
References: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
 <Pine.LNX.4.61.0412130925510.2394@yvahk01.tjqt.qr> <41BDDB02.5020606@gmail.com>
 <Pine.LNX.4.61.0412132059290.3382@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, in case anyone actually cares, here's a patch (at the end of the 
>mail) to fix the nit. "x86" does seem to be in the majority compared to 
>"X86" in the Kconfig help texts, I guess we might as well make it 
>consistent..

Hopefully nobody gets the idea of changing the CONFIG_X86 in Kconfig to 
CONFIG_x86 ...




Jan Engelhardt
-- 
ENOSPC
