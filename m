Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbUKRVkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbUKRVkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUKRVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:38:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:51423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263014AbUKRVgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:36:11 -0500
Date: Thu, 18 Nov 2004 13:35:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Message-Id: <20041118133557.72f3b369.akpm@osdl.org>
In-Reply-To: <200411182203.02176.cova@ferrara.linux.it>
References: <200411182203.02176.cova@ferrara.linux.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti <cova@ferrara.linux.it> wrote:
>
> Just a reminder: it's possible to cause a kernel oops simply inserting and 
> removing a usb storage (flash pen); using ub driver doesn't improve the 
> situation; noticed in 2.6.9-rc4-mm1 and present in 2.6.10-rc2-mm2.
> The same device works just fine with 2.6.8.1 (mdk cooker)

OK, that's something we'd like to get fixed prior to 2.6.10.

> I can provide, as previously done, full log for oopses and other details, just 
> let me known. (the behaviour is quite the same as already reported, so I 
> don't want to waste bandwidth)

We waste truckloads of bandwidth on far less important things than this ;)

Please resend the report, including the oops trace and be sure to cc both
linux-kernel and linux-usb-devel, thanks.

