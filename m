Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161350AbWHDRwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbWHDRwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161353AbWHDRwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:52:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37539 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161350AbWHDRwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:52:14 -0400
Date: Fri, 4 Aug 2006 10:52:06 -0700
From: Greg KH <greg@kroah.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060804175206.GB11558@kroah.com>
References: <06B3FID11@briare1.heliogroup.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06B3FID11@briare1.heliogroup.fr>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 04:37:25PM +0000, Hubert Tonneau wrote:
> Takashi Iwai wrote:
> >
> > Well, incompatibility is worse in most cases than rationality.
> > Could you test the patch really fixes your case, so that I can push it
> > to 2.6.17-stable tree?
> 
> With your patch, opening /dev/dsp O_RDWR works under 2.6.17 just like it
> did under 2.6.16 and previous.

Great, thanks for testing.  Takashi, care to send that patch to
stable@kernel.org so we can add it to the next stable release?

thanks,

greg k-h
