Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTDJFTt (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 01:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDJFTt (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 01:19:49 -0400
Received: from [196.41.29.142] ([196.41.29.142]:64251 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263984AbTDJFTs (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 01:19:48 -0400
Subject: Re: i2c questions in kernel 2.5.67
From: Martin Schlemmer <azarah@gentoo.org>
To: Stian Jordet <liste@jordet.nu>
Cc: Greg KH <greg@kroah.com>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1049906049.1379.18.camel@chevrolet.hybel>
References: <1049902006.1362.6.camel@chevrolet.hybel>
	 <20030409162537.GB1518@kroah.com>
	 <1049906049.1379.18.camel@chevrolet.hybel>
Content-Type: text/plain
Organization: 
Message-Id: <1049952444.2754.41.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Apr 2003 07:27:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 18:34, Stian Jordet wrote:
> ons, 09.04.2003 kl. 18.25 skrev Greg KH:
> > On Wed, Apr 09, 2003 at 05:26:46PM +0200, Stian Jordet wrote:
> > > Hi,
> > > 
> > > I have a Asus CUV266-DLS motherboard, with a as99127f hardware monitor
> > > chip. This is supposed to be supported by the W83781D sensor driver.
> > 
> > Does this motherboard work with this driver on 2.4?  (I'd recommend
> > getting the lm_sensors package from their web site to check this out.)
> > 
> 
> I haven't bothered to try. Haven't used 2.4 for ages. I'll try to test
> it tonight, else it have to wait untill after Easter.
> 
> But I guess this answered my question, whether something else is needed
> as well. Which I understand it is not. Damn.
> 

I cannot remember what exactly, but there is some weirdness with sysfs
and using find.  And unfortunately I could only test the driver with one
of the many chips it support (which on the newer Asus boards is not the
as99127f).  Can you attach a dmesg though ?

I will be back home in about 12-14 hours, then I can have a look ... is
this before or ater the easter deadline ? =)


Regards,

-- 
Martin Schlemmer


