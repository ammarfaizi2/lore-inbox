Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUJJEwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUJJEwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 00:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUJJEwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 00:52:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:57818 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268105AbUJJEwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 00:52:02 -0400
Date: Sat, 9 Oct 2004 21:51:31 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: CaT <cat@zip.com.au>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20041010045131.GB28920@kroah.com>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org> <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org> <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org> <20041002045725.GC1049@zip.com.au> <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org> <20041010021929.GA1322@zip.com.au> <Pine.LNX.4.58.0410092002070.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410092002070.3897@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 08:15:07PM -0700, Linus Torvalds wrote:
> 
> I wonder if request_resource() is broken. "insert_resource()" had been 
> broken for a _loong_ time (since its inception), maybe 
> "request_resource()" also is. Hmm..
> 
> Greg, do you see something I've missed? I feel stupid.

I don't see anything either :(

greg k-h
