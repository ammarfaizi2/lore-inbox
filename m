Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUGGAFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUGGAFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGGAFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:05:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:58582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264762AbUGGAFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:05:34 -0400
Date: Tue, 6 Jul 2004 17:08:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash city this morning
Message-Id: <20040706170838.5e69d9b4.akpm@osdl.org>
In-Reply-To: <200407061142.56009.gene.heskett@verizon.net>
References: <200407061142.56009.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> While running 2.6.7-mm6, my mouse usb has now powered itself down 2 
> times, requireing a reboot to recover, and this last time I rebooted 
> to 2.6.7 plain, but have had at least 3 pieces of kde do an exit 
> since doing so.

Please retest without the nvidia driver, then include
linux-usb-devel@lists.sourceforge.net in the bug report.
