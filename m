Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUCNRKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUCNRKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:10:24 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:33637 "EHLO
	mwinf0804.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261460AbUCNRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:10:20 -0500
Date: Sun, 14 Mar 2004 18:11:00 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Joerg Sommrey <jo@sommrey.de>, linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
Message-ID: <20040314181100.GA385@zaniah>
References: <200403141212.i2ECC5vo008463@harpo.it.uu.se> <20040314161233.GA2955@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314161233.GA2955@sommrey.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004 at 17:12 +0000, Joerg Sommrey wrote:

> nmi_watchdog=2 has never worked for me. Is this really supposed to work
> on a SMP machine? In that case there isn't even a message
> about activating the watchdog, but I get a nmi-count in /proc/interrupts. 

nmi_watchdog=2 is not tested on SMP so it works w/o any notice.

regards,
Phil

