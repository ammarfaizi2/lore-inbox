Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWEAUUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWEAUUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWEAUUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:20:22 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59831 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932224AbWEAUUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:20:21 -0400
Date: Mon, 1 May 2006 22:20:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <1146502730.2885.128.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0605012219560.32033@yvahk01.tjqt.qr>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> 
 <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
 <1146502730.2885.128.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What about task_t vs struct task_struct? Both are used in the kernel. 
>
>task_t should probably die.

Acked.



Jan Engelhardt
-- 
