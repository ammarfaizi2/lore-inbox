Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVL0Dq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVL0Dq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVL0Dq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:46:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:65005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932210AbVL0Dqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:46:55 -0500
Date: Mon, 26 Dec 2005 19:46:23 -0800
From: Greg KH <greg@kroah.com>
To: gcoady@gmail.com
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.5
Message-ID: <20051227034622.GA23521@kroah.com>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 02:06:03PM +1100, Grant Coady wrote:
> On Mon, 26 Dec 2005 16:53:27 -0800, Greg KH <gregkh@suse.de> wrote:
> 
> >We (the -stable team) are announcing the release of the 2.6.14.5 kernel.
> >
> >The diffstat and short summary of the fixes are below.
> >
> >I'll also be replying to this message with a copy of the patch between
> >2.6.14.4 and 2.6.14.5, as it is small enough to do so.
> 
> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
> on this box) or 2.4.32 :(  Same ruleset as used for months.

Is it broken compared to 2.6.14.4 and/or 2.6.14?  Care to figure out
which release broke it?

thanks,

greg k-h
