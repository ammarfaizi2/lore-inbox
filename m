Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUI3Vqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUI3Vqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3Vqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:46:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:24755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269531AbUI3Vqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:46:32 -0400
Date: Thu, 30 Sep 2004 14:50:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: greg@kroah.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-Id: <20040930145014.71e04b25.akpm@osdl.org>
In-Reply-To: <4157CA04.5050604@jp.fujitsu.com>
References: <41498CF6.9000808@jp.fujitsu.com>
	<20040924130251.A26271@unix-os.sc.intel.com>
	<20040924212208.GD7619@kroah.com>
	<4157CA04.5050604@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>
> I'm attaching updated patches for adding pcibiod_disable_device()
> hook based on the feedback from Ashok (Thank you, Ashok!).

This appears to be a patch-reversed version of the patch which is already
in -mm:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/broken-out/add-hook-for-pci-resource-deallocation.patch

So I'm not sure what you're trying to do here.
