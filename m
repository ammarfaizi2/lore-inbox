Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTEKFha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTEKFha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:37:30 -0400
Received: from granite.he.net ([216.218.226.66]:6413 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263445AbTEKFh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:37:29 -0400
Date: Sat, 10 May 2003 22:45:54 -0700
From: Greg KH <greg@kroah.com>
To: Mace Moneta <mmoneta@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
Message-ID: <20030511054554.GB7729@kroah.com>
References: <1052600695.12657.4.camel@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052600695.12657.4.camel@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 05:04:56PM -0400, Mace Moneta wrote:
> When Attempting to sync a Handspring Visor (PalmOS USB device), I
> sometimes (about 1 time out of 4) get the following panic.  

can you run that oops through ksymoops so that we can see where it died
at?

thanks,

greg k-h
