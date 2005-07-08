Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVGHUvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVGHUvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVGHUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:49:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262876AbVGHUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:47:57 -0400
Date: Fri, 8 Jul 2005 13:45:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: bero@arklinux.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, ipw2100-admin@linux.intel.com
Subject: Re: [-mm patch] is_broadcast_ether_addr() is still required
Message-Id: <20050708134543.1e5fa440.akpm@osdl.org>
In-Reply-To: <20050708200704.GH3671@stusta.de>
References: <20050708200704.GH3671@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch by Bernhard Rosenkraenzer <bero@arklinux.org> is still 
> required to fix the following compile error:

I think this problem is due to my failure to navigate the miasma of Jeff's
git trees.  I need to go in and look at all his branches and work out
what's missing.

