Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVLOW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVLOW5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLOW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:57:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:47583 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751186AbVLOW5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:57:54 -0500
Date: Thu, 15 Dec 2005 23:57:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <20051211180536.GM23349@stusta.de>
Message-ID: <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
References: <20051211180536.GM23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It seems most problems with 4k stacks are already resolved at least
>in -mm.
>
>I'd like to see this patch to always use 4k stacks in -mm now for 
>finding any remaining problems before submitting this patch for Linus' 
>tree.

By chance, I read that windows modules used in ndiswrapper
may require >4k-stacks. Will this become a problem?



Jan Engelhardt
-- 
