Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUEHLcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUEHLcV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUEHLcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:32:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:40091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263781AbUEHLcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:32:17 -0400
Date: Sat, 8 May 2004 04:31:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040508043149.63fd9498.akpm@osdl.org>
In-Reply-To: <200405081329.43017.rjwysocki@sisk.pl>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405072213.23167.rjwysocki@sisk.pl>
	<20040507230915.447a92fa.akpm@osdl.org>
	<200405081329.43017.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> Sute, it's like that:
> 
>  kernel /boot/vmlinuz-2.6.6-rc3-mm2 root=/dev/sdb3 vga=792 hdc=ide-scsi 
>  console=ttyS0,115200 console=tty0
> 

Please try `console=ttyS0'.
