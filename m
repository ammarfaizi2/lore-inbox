Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbUKKTi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbUKKTi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbUKKTi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:38:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16010 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262312AbUKKTiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:38:24 -0500
Date: Thu, 11 Nov 2004 11:38:09 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sparse "context" checking..
Message-ID: <20041111193809.GA7688@kroah.com>
References: <Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 08:20:53PM -0700, Linus Torvalds wrote:
> 
> I just committed the patches to the kernel to start supporting a new 
> automated correctness check that I added to sparse: the counting of static 
> "code context" information.

Nice, I like this a lot.  Already found some bugs in the USB drivers
that have been there forever.

thanks,

greg k-h
