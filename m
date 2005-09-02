Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVIBMOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVIBMOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVIBMOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:14:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61657 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751245AbVIBMOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:14:43 -0400
Subject: Re: [PATCH 1/12] UML - tty fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
References: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 13:38:35 +0100
Message-Id: <1125664715.30867.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 18:16 -0400, Jeff Dike wrote:
> This fixes a build breakage introduced by Alan's tty cleanups.  This should
> be tied to that patch if possible.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.13-mm1/arch/um/drivers/chan_kern.c
> ===================================================================

Acked-by: Alan Cox <alan@redhat.com>

(and applied to my tty tree for future diff generation)

