Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272059AbTG2W0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272130AbTG2W0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:26:35 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:21000 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272059AbTG2W0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:26:34 -0400
Date: Tue, 29 Jul 2003 23:26:20 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jakub Bogusz <qboosh@pld.org.pl>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: tdfxfb palette fix for 2.6.0-test2
In-Reply-To: <20030729221411.GA3434@satan.blackhosts>
Message-ID: <Pine.LNX.4.44.0307292325210.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have patches that fix this. I will make a new patch soon against 
test 2.

> Hello,
> 
> In 2.6.0-test2 text palette is broken in 16/24/32bpp modes on tdfxfb
> console (because of not using component length information).
> This patch fixes it; see also note inside.

