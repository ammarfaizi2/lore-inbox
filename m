Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTBWJ2e>; Sun, 23 Feb 2003 04:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbTBWJ2c>; Sun, 23 Feb 2003 04:28:32 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:26613 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S268091AbTBWJ0u>; Sun, 23 Feb 2003 04:26:50 -0500
Subject: Re: Problem: Palm Tungsten T + kernel 2.4.20 + Tungsten patch
	applied
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: private
Message-Id: <1045993013.1884.2.camel@aurich.ostfriesland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 23 Feb 2003 20:36:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

I'm an idiot! I thought I had tried this, but obviously I hadn't: Things
are working fine with /dev/ttyUSB0 instead of /dev/ttyUSB1.

Thanks heaps!
Andree

On Sat, 2003-02-22 at 01:43, Greg KH wrote: 
> On Fri, Feb 21, 2003 at 09:45:12PM +1100, Andree Leidenfrost wrote:
> > Syncing my m505 works fine, but I'd love to be able to sync my new and
> > shiny Tungsten T... ;-)
> 
> Try using /dev/ttyUSB0 instead of /dev/ttyUSB1, some people have
> reported that this is necessary.  If this doesn't work, the pilot-link
> mailing list should be able to help you out.
> 
> Good luck,
> 
> greg k-h



-- 
Andree Leidenfrost
Sydney - Australia

