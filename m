Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278354AbRJWWhg>; Tue, 23 Oct 2001 18:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278357AbRJWWh1>; Tue, 23 Oct 2001 18:37:27 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:43246 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S278354AbRJWWhP>; Tue, 23 Oct 2001 18:37:15 -0400
Date: Wed, 24 Oct 2001 00:37:47 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] USB, Palm M500, Coldsync
Message-ID: <20011024003747.A6529@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011023191458.A4261@oisec.net> <20011023103727.C9943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011023103727.C9943@kroah.com>
User-Agent: Mutt/1.3.23i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:37:27AM -0700, Greg KH wrote:
> On Tue, Oct 23, 2001 at 07:14:58PM +0200, Cliff Albert wrote:
> > Hi,
> > 
> > Coldsync segfaults after a successful hotsync with my Palm M500 which
> > is connected using the USB Cradle. It also generates a oops. I hope
> > the following info is enough to fix this problem.
> 
> This isn't a coldsync bug :)
> 
> A number of other people have reported this problem, and it is on my
> TODO list to fix.
> 
> Thanks for the oops trace.

I have three more if you're interested.  Kernel 2.4.12 (from Debian
unstable), coldsync 2.2.0, USB Palm m500.  Disclaimer: NVdriver.o is
loaded...

Marius Gedminas
-- 
If you are angry with someone, you should walk a mile in their shoes... then
you'll be a mile away from them, and you'll have their shoes.
