Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVCKSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVCKSNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCKSNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:13:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261265AbVCKSKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:10:20 -0500
Date: Fri, 11 Mar 2005 18:10:12 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: move powermac backlight stuff to a workqueue
In-Reply-To: <1110519593.5751.9.camel@gaston>
Message-ID: <Pine.LNX.4.56.0503111809080.10827@pentafluge.infradead.org>
References: <1110519593.5751.9.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I hope I'll replace this by the new backlight framework in a future
> kernel version, but for now, this will fix the immediate issues with
> radeon.

Is it possible to move it over to the new backlight code that is in 
drivers/video/backlight ?

