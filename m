Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752068AbWCKHxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbWCKHxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWCKHxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:53:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752068AbWCKHxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:53:18 -0500
Date: Fri, 10 Mar 2006 23:51:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
Message-Id: <20060310235103.4e9c9457.akpm@osdl.org>
In-Reply-To: <1142063254.3055.9.camel@laptopd505.fenrus.org>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	<20060310145605.08bf2a67.akpm@osdl.org>
	<1142061816.3055.6.camel@laptopd505.fenrus.org>
	<20060310234155.685456cd.akpm@osdl.org>
	<1142063254.3055.9.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> 
> > 
> > > but yeah by this time we should just bite the bullet and rename the
> > > variable rather than move it about
> > 
> > That wouldn't help - we'll still break existing scripts.
> 
> why? (I mean the KERN_ to FS_ rename in the kernel, that's not exported
> to userland anywhere)

oic.  What are you expecting here?  Reading skills?
