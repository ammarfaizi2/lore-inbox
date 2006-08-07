Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWHGFGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWHGFGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWHGFGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:06:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39809 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751038AbWHGFGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:06:01 -0400
Date: Mon, 7 Aug 2006 06:06:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.18-rc4
Message-ID: <20060807050600.GM29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org> <20060806224814.GA15883@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806224814.GA15883@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 03:48:14PM -0700, Greg KH wrote:
> On Sun, Aug 06, 2006 at 11:35:52AM -0700, Linus Torvalds wrote:
> > Anyway, I'll be effectively offline for most of the following three weeks 
> > (vacations and a funeral), and while I hope to be able to update my tree 
> > every once in a while, I also asked Greg KH to maintain a git tree for any 
> > worthwhile fixes.
> 
> And for people who want to watch that tree, it can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.git/
> 
> Right now it only has 2 JFS patches which it seems that Linus missed
> before he did 2.6.18-rc4.

There's also a bunch of build fixes; will send your way...
