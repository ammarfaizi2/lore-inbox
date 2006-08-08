Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWHHI3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWHHI3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWHHI3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:29:46 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:16043 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932574AbWHHI3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:29:45 -0400
Subject: Re: [PATCH 2/9] Replace __ARCH_HAS_DO_SOFTIRQ with
	CONFIG_ARCH_DO_SOFTIRQ
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>, paulus@samba.org
In-Reply-To: <20060807141109.7e4d912d.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
	 <20060807141109.7e4d912d.rdunlap@xenotime.net>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 08 Aug 2006 10:29:43 +0200
Message-Id: <1155025783.26277.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 14:11 -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Replace __ARCH_HAS_DO_SOFTIRQ with CONFIG_ARCH_DO_SOFTIRQ.
> Move it from header files to Kconfig space.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


