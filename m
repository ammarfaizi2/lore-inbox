Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUHJMnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUHJMnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUHJMmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:42:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54732 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264665AbUHJMj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:39:57 -0400
Subject: Re: [PATCH 2.6] Remove spaces from MTD pci_driver.name field
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dsaxena@plexity.net
Cc: dwmw2@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810043710.GA11719@plexity.net>
References: <20040810043710.GA11719@plexity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092137846.16885.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 12:37:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 05:37, Deepak Saxena wrote:
> -	.name =     "Intel SCB2 BIOS Flash",
> +	.name =     "Intel_SCB2_BIOS",

This not only remove spaces (arguable) it also changes other parts
of the naming.

