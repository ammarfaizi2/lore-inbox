Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWDXWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWDXWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDXWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:43:08 -0400
Received: from mail.suse.de ([195.135.220.2]:37605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751339AbWDXWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:43:07 -0400
Date: Mon, 24 Apr 2006 15:41:54 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs removal patches for -mm
Message-ID: <20060424224154.GA13336@kroah.com>
References: <20060424213245.GA28618@kroah.com> <20060424153103.64178e17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424153103.64178e17.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 03:31:03PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > Could you please add my "remove devfs" series of patches to the -mm
> > tree?  They are contained in:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
> 
> That seems to go in OK.  The only patch-time clash with pending subsystem
> trees is in drivers/s390/net/ctctty.c, which was removed in Jeff's
> git-netdev-all.patch.

Great, thanks for letting me know.  I'll be keeping them up to date with
regards to mainline like the other trees.

thanks,

greg k-h
