Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUGEVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUGEVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUGEVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:52:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:21438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbUGEVw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:52:58 -0400
Date: Mon, 5 Jul 2004 14:51:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michael Thonke" <TK-SHOCKWAVE@web.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.7-mm6 usb lockup also with reverted bk-usb.path and
 usb-locking-fix
Message-Id: <20040705145154.20ffff21.akpm@osdl.org>
In-Reply-To: <971479910@web.de>
References: <971479910@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Thonke" <TK-SHOCKWAVE@web.de> wrote:
>
> Hello Andrew,
> 
> I followed your advise in the changlog.I reverted the bk-usb.patch and usb-loocking-fix but my system still not boot after the frist uhci_hcd detected. And now I don`t know what is wrong 2.6.7-mm5 works fine.
> 
> My system is a Intel Pentium 4 (Prescott) and HT enabled also the motherboard is from Abit (IC7 model) any hints or help are welcome.
> 

Could you try reverting bk-acpi as well?
