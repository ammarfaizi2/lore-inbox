Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWIBJvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIBJvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 05:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWIBJvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 05:51:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61419 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750953AbWIBJvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 05:51:45 -0400
Date: Sat, 2 Sep 2006 02:51:43 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@suse.de>, andrew@digital-domain.net
Subject: Re: [Bugme-new] [Bug 7065] New: Devices no longer automount
Message-ID: <20060902095143.GA27196@kroah.com>
References: <200608281700.k7SH0CYl013187@fire-2.osdl.org> <20060828121057.035fd690.akpm@osdl.org> <20060902094239.GH26849@kroah.com> <44F95364.8020901@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F95364.8020901@goop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2006 at 02:48:20AM -0700, Jeremy Fitzhardinge wrote:
> Greg KH wrote:
> >This was narrowed down to a broken userspace configuration by the
> >freedesktop.org developers.
> >
> >Many thanks to them.
> >
> >So no kernel issue here.
> >  
> 
> Do you have a reference to what the fix is?

Are you having this same problem?  I think it was an invalid HAL
configuration file from what I heard.  Kay would know for sure.

thanks,

greg k-h

-- 
VGER BF report: H 0
