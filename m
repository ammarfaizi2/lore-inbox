Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTEMEqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEMEqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:46:23 -0400
Received: from granite.he.net ([216.218.226.66]:49423 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261359AbTEMEqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:46:22 -0400
Date: Mon, 12 May 2003 22:00:56 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513050056.GA6197@kroah.com>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <20030513040557.GV10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513040557.GV10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:05:57AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> BTW, somebody will have to document the tty driver and ldisc API.

I've been working on documenting the current tty API and hope to do the
ldisc API too.  I guess I should put it up somewhere for people to poke
at...

Or do you mean document your changes in the API?  I've been trying to
keep up to date (got the recent ioctl changes that went in a few
versions ago) and would be glad to try to keep it current.

thanks,

greg k-h
