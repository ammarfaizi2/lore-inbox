Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUKWHjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUKWHjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUKWHjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:39:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:59017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262282AbUKWHjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:39:09 -0500
Date: Mon, 22 Nov 2004 23:38:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
Message-Id: <20041122233852.43f93aa9.akpm@osdl.org>
In-Reply-To: <200411230014.15354.gene.heskett@verizon.net>
References: <200411230014.15354.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> Just built bk7 after running the bk4-kjt1 version for a cpouple of 
>  days, and noticed this in /var/log/dmesg:
> 
>  >From grub.conf to dmesg:
>  Kernel command line: ro root=/dev/hda7 acpi_skip_timer_override
> 
>  Then, quite a ways down in that logfile:

Please post the full dmesg output.
