Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTHSVoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbTHSVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:41:40 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:57030 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261533AbTHSVe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:34:29 -0400
Subject: Re: Can't read fan-speeds from i2c
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030819210223.GB6170@kroah.com>
References: <1061324213.708.6.camel@chevrolet.hybel>
	 <20030819205356.GA5968@kroah.com> <1061326633.611.8.camel@chevrolet.hybel>
	 <20030819210223.GB6170@kroah.com>
Content-Type: text/plain
Message-Id: <1061328876.611.31.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 23:34:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 23.02 skrev Greg KH:
> On Tue, Aug 19, 2003 at 10:57:13PM +0200, Stian Jordet wrote:
> > tir, 19.08.2003 kl. 22.53 skrev Greg KH:
> > > On Tue, Aug 19, 2003 at 10:16:53PM +0200, Stian Jordet wrote:
> > > > Hi,
> > > > 
> > > > I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> > > > seems to work as it is supposed to, except for fan-speeds. They say 0.
> > > > Is that supposed behaviour since the as99127f doesn't have any
> > > > datasheets, or am I doing something wrong?
> > > 
> > > What kernel version are you using?
> > 
> > Latest bk-snapshot...
> 
> Does 2.4 work just fine for this chip and driver and 2.6 does not?  If
> 2.4 also doesn't work, I would suggest bringing this up on the sensors
> mailing list.

Doesn't work with 2.4 neither. I'll try the list, but I don't have much
hope for them doing anything. Quoting from the their webpage:

If you have problems, please lobby Asus to release a datasheet.
Unfortunately several others have without success.
Please do not send mail to us asking for better as99127f support.

Which I do ofcourse understand. I just wondered if there was some voodoo
I didnt' understand. Works fine with Motherboard Monitor 5 in Windows.

Thanks :)

Best regards,
Stian

