Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTDIR05 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTDIR05 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:26:57 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:40921 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263647AbTDIR0z (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:26:55 -0400
Subject: Re: i2c questions in kernel 2.5.67
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030409173733.GA14064@kroah.com>
References: <1049902006.1362.6.camel@chevrolet.hybel>
	 <20030409162537.GB1518@kroah.com> <1049909342.1269.0.camel@chevrolet.hybel>
	 <20030409173733.GA14064@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049909944.1268.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Apr 2003 19:39:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 09.04.2003 kl. 19.37 skrev Greg KH:
> On Wed, Apr 09, 2003 at 07:29:03PM +0200, Stian Jordet wrote:
> > ons, 09.04.2003 kl. 18.25 skrev Greg KH:
> > > On Wed, Apr 09, 2003 at 05:26:46PM +0200, Stian Jordet wrote:
> > > > Hi,
> > > > 
> > > > I have a Asus CUV266-DLS motherboard, with a as99127f hardware monitor
> > > > chip. This is supposed to be supported by the W83781D sensor driver.
> > > 
> > > Does this motherboard work with this driver on 2.4?  (I'd recommend
> > > getting the lm_sensors package from their web site to check this out.)
> > 
> > Of course I should have checked this better before I sent the first
> > mail. I need the i2c-viapro module (in 2.4), which hasn't been ported
> > yet.
> 
> No problem, want to port that driver and send me a patch?  :)
> 
> I sent out a document to the list a week or so ago on the changes
> necessary to do this if you're interested.

Hmm. I might try, I'll have to see how much spare time I get.

Thanks :)

Best regards,
Stian

