Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTAUHHC>; Tue, 21 Jan 2003 02:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbTAUHHC>; Tue, 21 Jan 2003 02:07:02 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:20608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S266318AbTAUHHB>; Tue, 21 Jan 2003 02:07:01 -0500
Subject: Re: cs89x0 in 2.5 (was Re: eepro100 - 802.1q - mtu size)
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, alan@redhat.com, akpm@digeo.com
In-Reply-To: <20030117174928.GA8304@gtf.org>
References: <20030117145357.GA1139@paradigm.rfc822.org>
	 <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org>
	 <20030117172719.GA31343@codemonkey.org.uk>  <20030117174928.GA8304@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043115448.13142.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 02:17:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 17:49, Jeff Garzik wrote:
> > Whilst on the subject of magic numbers in net drivers, did we ever get
> > to the bottom of 2.4's ChangeSet 1.587.9.20 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/split-dj1/net-cs89x0-media-corrections.diff
> 
> 
> IIRC it came from -ac tree without explanation, and I think akpm said it
> broke stuff.  Since it has an alive maintainer (akpm), I would rather
> let Alan and Andrew fight it out :)  Whatever they decide is fine with
> me for 2.5.

I've had no reports I remember about it breaking stuff, and several that
it fixed stuff. It also seems to match the documentation. Its been in -ac
for ages

