Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWEVVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWEVVqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWEVVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:46:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:3537 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751219AbWEVVqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:46:20 -0400
Date: Mon, 22 May 2006 14:44:03 -0700
From: Greg KH <gregkh@suse.de>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060522214403.GA7044@suse.de>
References: <20060522143043.GA6408@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522143043.GA6408@fks.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 04:30:48PM +0200, Frank Gevaerts wrote:
> Hi, 
> 
> We are having problems with the usb-serial ipaq driver in 2.6.16 (debian
> backports 2.6.16-1-686, but also reproducible with self-compiled
> kernel.org kernel)
> 
> Sometimes, we get the following on disconnect:

<snip>

Can you duplicate this on 2.6.17-rc4?  A number of tty changes went into
that release that should have fixed this issue.

thanks,

greg k-h

