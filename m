Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCPTLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUCPTLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:11:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:46308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261321AbUCPTLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:11:46 -0500
Date: Tue, 16 Mar 2004 11:10:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
Message-Id: <20040316111026.6729e153.akpm@osdl.org>
In-Reply-To: <20040316153719.GA13723@kroah.com>
References: <4056B0DB.9020008@pobox.com>
	<20040316005229.53e08c0c.akpm@osdl.org>
	<20040316153719.GA13723@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 16, 2004 at 12:52:29AM -0800, Andrew Morton wrote:
> > 
> > It's so long since klibc was discussed (ie: more than five minutes ago)
> > that I forget the reasons why it should be delivered via the kernel tree.
> > 
> > Remind me please?
> 
> We need a way to build the userspace programs that get put into
> initramfs that will be needed to boot the kernel.
> 
> That help?

My grey cells thank you.

Does klibc have a bk home anywhere, so I can start sucking it in?
