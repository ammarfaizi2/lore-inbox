Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWHNPXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWHNPXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWHNPXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:23:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:57276 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750828AbWHNPXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:23:52 -0400
Date: Mon, 14 Aug 2006 17:23:32 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT not active
In-Reply-To: <1155568787.2886.265.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0608141723040.32435@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
 <1155568787.2886.265.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>the "ht" flag does not mean what you think it means.....
>it does NOT mean "I can use hyperthreading on this machine"; it
>basically means "the ht cpuid commands work", so that linux can find the
>nr of siblings, which can be..... 1
> 
Alright. I am just waiting for a CPU which has an XMAS CPUID...


Jan Engelhardt
-- 
