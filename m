Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWDRPlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWDRPlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDRPlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:41:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:22480 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWDRPlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:41:00 -0400
Date: Tue, 18 Apr 2006 08:39:51 -0700
From: Greg KH <greg@kroah.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.7
Message-ID: <20060418153951.GC30485@kroah.com>
References: <20060418042300.GA11061@kroah.com> <20060418042345.GB11061@kroah.com> <44448DFF.3080108@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44448DFF.3080108@ums.usu.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 12:58:07PM +0600, Alexander E. Patrakov wrote:
> Greg KH wrote:
> >-EXTRAVERSION = .6
> >+EXTRAVERSION = .7
> 
> Hello, I would like to know if there is a plan to include this in the next 
> -stable update?
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=2731570eba5b35a21c311dd587057c39805082f1;hp=dfb62998866ae2e298139164a85ec0757b7f3fc7;hb=9469d458b90bfb9117cbb488cfa645d94c3921b1;f=net/core/dev.c

No one has submitted it to the stable@kernel.org mail address from what
I can see, so no, it is not in the queue.  If you think otherwise,
please send it.

thanks,

greg k-h
