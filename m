Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUHJNCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUHJNCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUHJM7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:59:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58828 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265040AbUHJMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:55:22 -0400
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dsaxena@plexity.net
Cc: greg@kroah.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810021209.GA10495@plexity.net>
References: <20040810001316.GA7292@plexity.net>
	 <1092096699.14934.4.camel@localhost.localdomain>
	 <20040810021209.GA10495@plexity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092138774.16979.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 12:52:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 03:12, Deepak Saxena wrote:
> Files w/o spaces look better and is easier to work with if running 
> from cmd line, but if we ignore the "prettyness" issue, we should at 
> least try to be consistent. Either we have spaces and _all_ driver 
> names are in the format "xxx IDE", "xxx i2c", etc, or we don't allow
> space at all. 

Any command line tool has to be robust for space handling anyway.

Alan

