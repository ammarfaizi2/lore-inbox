Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbUBXW2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUBXW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:28:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:44213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262500AbUBXW2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:28:31 -0500
Date: Tue, 24 Feb 2004 14:30:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-Id: <20040224143025.36395730.akpm@osdl.org>
In-Reply-To: <403BCE9E.7080607@matchmail.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<403BCE9E.7080607@matchmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/
> 
> Hi,
> 
> I have 2.6.3 on the 1.5GB RAM server that started the "large slab" thread.
> 
> Which patches should I apply from -mm to test for improvements?

Just apply the mm3 rollup patch.

> Do these below have any dependencies not listed?

Probably not.  If they apply ten they'll work.

> What about Nick's fix up patch for the two patches above?  Should I 
> include that one also?

yes.
