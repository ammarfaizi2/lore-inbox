Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVBAAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVBAAtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVBAAcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:32:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:50055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261445AbVAaX6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:58:18 -0500
Date: Mon, 31 Jan 2005 15:28:10 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jiang <dave.jiang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux@arm.linux.org.uk, smaurer@teja.com,
       dsaxena@plexity.net, mporter@kernel.crashing.org,
       drew.moseley@intel.com
Subject: Re: [PATCH 1/5] resource: core changes to update u64 to unsigned long
Message-ID: <20050131232810.GB27045@kroah.com>
References: <20050114200103.GA19386@plexity.net> <20050114210438.GA21248@plexity.net> <20050114213250.GB21248@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114213250.GB21248@plexity.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:32:50PM -0800, Dave Jiang wrote:
> Here's the prink's with the proper cast I think. Should only be change
> in core and driver. The arch patches are fine.

Thanks, I've applied this one, and the other 4 to my bk trees, and they
will show up in the next -mm releases.  After 2.6.11 is out, I'll send
them off to Linus.

Thanks again.

greg k-h
