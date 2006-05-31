Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWEaV6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWEaV6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWEaV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:58:00 -0400
Received: from ns1.suse.de ([195.135.220.2]:41384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965187AbWEaV57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:57:59 -0400
Date: Wed, 31 May 2006 14:55:23 -0700
From: Greg KH <gregkh@suse.de>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Pete Zaitcev <zaitcev@redhat.com>, lcapitulino@mandriva.com.br,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060531215523.GA13745@suse.de>
References: <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531213828.GA17711@fks.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 11:38:28PM +0200, Frank Gevaerts wrote:
> On Tue, May 30, 2006 at 11:33:27AM -0700, Pete Zaitcev wrote:
> > 
> > Please get rid of the above.
> > >  	 * shut down bulk read and write
> 
> OK, So here's the corrected patch:
> 
> Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

Care to send it with a proper changelog description?  And not the
usb-serial.c fix as that's already in my tree.

thanks,

greg k-h
