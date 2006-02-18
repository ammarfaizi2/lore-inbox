Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWBRAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWBRAfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWBRAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:35:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44187
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751808AbWBRAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:35:34 -0500
Date: Fri, 17 Feb 2006 16:35:16 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060218003516.GA474@kroah.com>
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org> <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F641A2.50200@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:35:30PM -0500, Bill Davidsen wrote:
> I not entirely sure about having classes other than cdrom, just because 
> we already have CD, DVD, DVD-DL, and are about to add blue-ray and 
> HD-DVD, so if I can tell that it's a removable device which can read 
> CDs, the applications have a fighting chance to looking at the device to 
> see what it is. As a human I would like the model information because 
> the kernel has done the work, why should people have to chase it when it 
> could be in one place?

Sure, I don't object to that at all, as long as you can detect this kind
of information easily from within the kernel.

thanks,

greg k-h
