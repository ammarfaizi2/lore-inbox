Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265142AbVBECas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbVBECas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbVBECar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:30:47 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:55979 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265142AbVBECaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:30:39 -0500
Subject: Re: 2.6: USB disk unusable level of data corruption
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20050205014413.GB31596@kroah.com>
References: <1107519382.1703.7.camel@localhost.localdomain>
	 <20050204133726.7ba8944f@localhost.localdomain>
	 <1107564013.10471.3.camel@localhost.localdomain>
	 <20050205014413.GB31596@kroah.com>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 21:30:45 -0500
Message-Id: <1107570646.7049.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does 2.6.11-rc3 have this same issue?
> 
> thanks,
> 
> greg k-h

I just compiled 2.6.11-rc3 booted and then again did a kernel compile on
the USB disk - no problems. 

With FC 2.6.10 kernel I am able to reproduce the problem within no time
- seems something is seriously broken in FC3 latest kernel. 

Parag

