Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUBGH0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 02:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUBGH0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 02:26:03 -0500
Received: from fmr04.intel.com ([143.183.121.6]:55940 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265810AbUBGH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 02:26:00 -0500
Subject: Re: swusp acpi
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E83B3@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E83B3@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076138717.2562.1801.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Feb 2004 02:25:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,
my serial console is toast on 2.6 after resume.  Can you point me to
said patch?

thanks,
-Len

On Thu, 2004-01-22 at 15:43, Pavel Machek wrote:
> Hi!
> 
> > Michael Frank has done a patch giving 2.4 PM support for serial
> ports
> > (my serial console now works flawlessly). Perhaps it could be ported
> to
> > 2.6 and the driver model...
> 
> That would certainly be good thing (tm).
> 
> >
> > Nigel
> >
> > On Thu, 2004-01-22 at 23:26, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > Not only serial console... Noone wrote serial port support.
> > > >
> > > > Incorrect.  I never merged the changes because it's rather too
> hacky.
> > >
> > > Who wrote them? Do you have that patch somewhere?
> > >                                                             Pavel
> > --
> > My work on Software Suspend is graciously brought to you by
> > LinuxFund.org.
> 
> 
> 
> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1
> ms        
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

