Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWGYSqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWGYSqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWGYSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:46:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:41649 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751470AbWGYSqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:46:17 -0400
Date: Tue, 25 Jul 2006 11:41:58 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-stable <stable@kernel.org>
Subject: Re: [stable] Success: tty_io flush_to_ldisc() error message triggered
Message-ID: <20060725184158.GH9021@kroah.com>
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com> <44C25548.5070307@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C25548.5070307@microgate.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 11:41:44AM -0500, Paul Fulghum wrote:
> Chuck Ebbert wrote:
> > The cleaner fix looks more intrusive, though.
> > 
> > Is this simpler change (what I'm running but without the warning
> > messages) the preferred fix for -stable?
> 
> It fixes the problem.

So do you feel this patch should be added to the -stable kernel tree?

thanks,

greg k-h
