Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269780AbUIDGoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269780AbUIDGoH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269824AbUIDGoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:44:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:3220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269780AbUIDGoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:44:04 -0400
Date: Fri, 3 Sep 2004 23:42:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steffen Zieger <lkml@steffenspage.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Codemercs IO-Warrior support
Message-Id: <20040903234208.380eeb64.akpm@osdl.org>
In-Reply-To: <200409032114.08743.lkml@steffenspage.de>
References: <200409032114.08743.lkml@steffenspage.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Zieger <lkml@steffenspage.de> wrote:
>
> Hello list,
> 
> here is a patch to get the kernel module from Codemerces to work.

It's wordwrapped by your email client.

> The module is available in source for the 2.4 and 2.6 series except the needed 
> changes in hid-core.c. Codemercs distribute the needed changes as a complete 
> file (version 2.6.4). This isn't working with 2.6.8.1.
> 
> Is there any possibility to get Codemerces driver for the IO-Warrior in the 
> kernel?
> The complete code is under the GPL licensed.

The authors shuld submit the driver as a patch against current -linus
kernel.
