Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVGKNkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVGKNkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGKNkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:40:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37581 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261676AbVGKNi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:38:56 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050707130607.GC28489@infradead.org>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <20050707130607.GC28489@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121088922.7407.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 14:35:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No reason to use the horror it is as-is.  Beein hardware description they
> won't change ever except for additions, so just clean the mess up into
> somethign nice and submit them.  You could have done so in the time you
> spent arguing on linux-arm-kernel already.

Or written a perl script to reprocess them into something saner for that
matter. The licensing does look problematic - perhaps Atmel will be
happy to dual license them (see the many BSD bits of code that are in
kernel and say
things like "or at your option you may use the GNU Public License
version 2 or
later" and similar.


