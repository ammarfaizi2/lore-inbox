Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUIGSOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUIGSOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUIGSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:13:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:31141 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268317AbUIGSLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:11:45 -0400
Subject: Re: [PATCH] mark install_page static
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907143741.GA8606@lst.de>
References: <20040907143741.GA8606@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094576968.9599.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:09:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
> Not used anywhere in modules and it really shouldn't either.

Doesn't that happen (conveniently from some viewpoints Im sure) to break
vmware ?

