Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVKQSNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVKQSNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVKQSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:13:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:39590 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964801AbVKQSNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:13:35 -0500
Date: Thu, 17 Nov 2005 09:58:11 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build error in current -git tree
Message-ID: <20051117175811.GA28263@kroah.com>
References: <20051117171047.GA27534@kroah.com> <Pine.LNX.4.64.0511170941220.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511170941220.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:42:12AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 17 Nov 2005, Greg KH wrote:
> >
> > In trying to build your kernel tree right now, I get the following
> > error:
> 
> Heh. That's what I get for being on ppc64 now.
> 
> This should fix it (and I'll try it out on my laptop before I commit it).

Yup, your commited change fixed it for me, thanks.

greg k-h
