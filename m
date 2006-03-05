Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWCEWaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWCEWaw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWCEWaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:30:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751835AbWCEWav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:30:51 -0500
Date: Sun, 5 Mar 2006 14:25:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ACPI should depend on, not select PCI
Message-Id: <20060305142554.1d0ee460.akpm@osdl.org>
In-Reply-To: <20060305222136.GD20287@stusta.de>
References: <20060305222136.GD20287@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> ACPI should depend on, not select PCI.
> 

It's surprising that there's any such linkage, actually.  Is it
impossible for a non-PCI system to have ACPI?

