Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUHJBOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUHJBOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUHJBOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:14:06 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58059 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267385AbUHJBOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:14:04 -0400
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dsaxena@plexity.net
Cc: greg@kroah.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810001316.GA7292@plexity.net>
References: <20040810001316.GA7292@plexity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092096699.14934.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 01:11:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 01:13, Deepak Saxena wrote:
> Spaces in driver names show up as spaces in sysfs. Annoying.  
> I went ahead and changed ones that don't have spaces to use
> ${NAME}_IDE so they are all consistent.

I don't see the problem with spaces in the filenames. I do see the 
problem in changing stuff under people for now reason other than
"I don't like it".

The existing format with spaces looks a lot better in all the
graphical file managers.

Alan
