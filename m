Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbTEVQsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTEVQsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:48:21 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:17102 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262816AbTEVQsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:48:19 -0400
Date: Thu, 22 May 2003 19:01:16 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522170116.GA18559@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030522164349.GA17830@ranty.ddts.net> <Pine.LNX.4.44.0305220950520.5889-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305220950520.5889-100000@cherise>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 09:51:36AM -0700, Patrick Mochel wrote:
> 
> >  Actually it is two files:
> > 
> >  	firmware_class.c:
> > 		the code itself
> > 	firmware_sample_driver.c:
> > 		sample code for driver writers.
> > 
> >  If you don't like having firmware_sample_driver.c there, it could be
> >  moved to Documentation/ or put in some web page.
> 
> I'd prefer that personally, with a comment on the location in 
> firmware_class.c.

 You mean moving it to Documentation or puting it in some web page?

 Just ignore the sample then.

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
