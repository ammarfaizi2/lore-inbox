Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJRJqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 05:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJRJqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 05:46:13 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:63135 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261332AbTJRJqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 05:46:10 -0400
Subject: Re: [2.6.0-test3,6,7] IDE 'enhanced mode' problems
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F8FE2D1.6090400@pobox.com>
References: <1066388412.1585.8.camel@paragon.slim>
	 <3F8FE2D1.6090400@pobox.com>
Content-Type: text/plain
Message-Id: <1066470285.1554.0.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sat, 18 Oct 2003 11:44:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 14:38, Jeff Garzik wrote:
> Jurgen Kramer wrote:
> > Hi,
> > 
> > I have various systems running 2.6.0-test kernels without problems so I
> > thought lets try 2.6.0-test7 on my main system again...I had run test3
> > without problems on this system but now all of a sudden it could not
> > boot 2.6.0-test3/6/7 normally. It would never pass through init
> > completely. It just stalled.
> > 
> > The only thing I changed since the last time I ran 2.6.0 successfully
> > was that I removed the SATA drive (I am running this on a Asus P4C800).
> > In the BIOS the IDE settings where still set to 'Enhanced mode'. The 2.4
> > kernel series doesn't seem to have a problem with it. I can't boot 2.6.0
> > with this setting on.
> > 
> > After changing the mode back to 'Compatible' I can run 2.6.0 properly
> > again.
> > 
> > Is this a bug in the IDE ICH5 code?
> 
> 
> Are you running libata?
> 
> 	Jeff
No. Just plain IDE.

Jurgen
> 

