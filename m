Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbTGGIiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbTGGIiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:38:17 -0400
Received: from ns.suse.de ([213.95.15.193]:22541 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266871AbTGGIiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:38:15 -0400
Date: Mon, 7 Jul 2003 10:52:47 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.22-pre3] fix x86-64 show_regs() loop
Message-Id: <20030707105247.14d34993.ak@suse.de>
In-Reply-To: <200307062239.h66Mdegl023758@harpo.it.uu.se>
References: <200307062239.h66Mdegl023758@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003 00:39:40 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> show_regs() should call __show_regs() not itself.

Oops @) 

Thanks for the fix.

-Andi
