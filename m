Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRB0VyK>; Tue, 27 Feb 2001 16:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRB0VyA>; Tue, 27 Feb 2001 16:54:00 -0500
Received: from [216.161.55.93] ([216.161.55.93]:24313 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129734AbRB0Vxq>;
	Tue, 27 Feb 2001 16:53:46 -0500
Date: Tue, 27 Feb 2001 13:58:11 -0800
From: Greg KH <greg@wirex.com>
To: Dag Brattli <dag@brattli.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        jt@bougret.hpl.hp.com
Subject: Re: [patch] patch-2.4.2-irda1 (irda-usb)
Message-ID: <20010227135810.E910@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Dag Brattli <dag@brattli.net>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	jt@bougret.hpl.hp.com
In-Reply-To: <20010227093329.A10482@wirex.com> <200102272032.UAA74232@tepid.osl.fast.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102272032.UAA74232@tepid.osl.fast.no>; from dag@brattli.net on Tue, Feb 27, 2001 at 08:32:28PM +0000
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 08:32:28PM +0000, Dag Brattli wrote:
> > I'd recommend that this file be in the /drivers/usb directory, much like
> > almost all other USB drivers are.
> 
> Yes, but do we want to spread the IrDA code around? The same argument
> applies to IrDA device drivers!?

I agree, and am not saying that it _has_ to be there.  Just a
suggestion, and if you're comfortable with it in the irda directory,
that's fine.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
