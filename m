Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946011AbWJaVQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946011AbWJaVQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWJaVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:16:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:445 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946011AbWJaVQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:16:17 -0500
Date: Tue, 31 Oct 2006 13:15:44 -0800
From: Greg KH <gregkh@suse.de>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: [PATCH 000 of 6] md: udev events and cache bypass for reads
Message-ID: <20061031211544.GB21597@suse.de>
References: <20061031164814.4884.patches@notabene>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031164814.4884.patches@notabene>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:00:40PM +1100, NeilBrown wrote:
> Following are 6 patches for md in -lastest which I have been sitting
> on for a while because I hadn't had a chance to test them properly.
> I now have so there shouldn't be too many bugs left :-)
> 
> First is suitable for 2.6.19 (if it isn't too late and gregkh thinks it
> is good).  Rest are for 2.6.20.

No objections from me.

thanks,

greg k-h
