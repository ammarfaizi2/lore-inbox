Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWHMQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWHMQxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWHMQxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:53:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61155 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751315AbWHMQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:53:51 -0400
Subject: Re: [PATCH for review] [123/145] i386: make fault notifier
	unconditional and export it
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060813152859.GB3543@stusta.de>
References: <20060810935.775038000@suse.de>
	 <20060810193722.8082B13B8E@wotan.suse.de> <20060813152859.GB3543@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Aug 2006 18:11:45 +0100
Message-Id: <1155489105.24077.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-13 am 17:28 +0200, ysgrifennodd Adrian Bunk:
> > It's needed for external debuggers and overhead is very small.
> >...
> 
> We are currently trying to remove exports not used by any in-kernel 
> code.

Wrong pronoun. I think you meant to type "You".


