Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVCUXuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVCUXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUXqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:46:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:17120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbVCUXpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:45:15 -0500
Date: Mon, 21 Mar 2005 15:45:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-Id: <20050321154512.266b44e6.akpm@osdl.org>
In-Reply-To: <422FFDEF.2060706@gts.it>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<422FFDEF.2060706@gts.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/
> 
> Hi Andrew
> 
> With 2.6.11-mm series, "acpi_poweroff called" problem is back again (it 
> disappeared in 2.6.11-rc-mm and actually never happend in Linus' tree). 
> So when you shutdown, you have to unplug power cord or so to switch off 
> because the system hangs after that message is displayed.
> 

Some work has been done on this in the ACPI tree.  Can you please test
2.6.12-rc1-mm1?
