Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbSISHus>; Thu, 19 Sep 2002 03:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270279AbSISHus>; Thu, 19 Sep 2002 03:50:48 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:14735 "EHLO
	starship") by vger.kernel.org with ESMTP id <S270274AbSISHur>;
	Thu, 19 Sep 2002 03:50:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.26 hotplug failure
Date: Thu, 19 Sep 2002 09:55:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Brad Hards <bhards@bigpond.net.au>, Duncan Sands <duncan.sands@wanadoo.fr>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rvs3-0000uN-00@starship> <20020919074844.GC13487@kroah.com>
In-Reply-To: <20020919074844.GC13487@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rwAI-0000vM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 September 2002 09:48, Greg KH wrote:
> On Thu, Sep 19, 2002 at 09:37:07AM +0200, Daniel Phillips wrote:
> > On Wednesday 18 September 2002 18:55, Greg KH wrote:
> > > Sorry, but I'm not going to put the file back.  I understand your
> > > concerns.  We should have some kind of program (lsdev like) that shows
> > > the system information present at that moment in time.  It will be able
> > > to provide what the /proc/bus/usb/drivers file showed in the past.
> > 
> > How about calling it /proc/bus/usb/drivers?
> 
> Please go back and read what I wrote above what you snipped out and then
> explain how this would be possible.

I don't get it.  What's the problem?  Not that I'm advocating that proc have
functionality that can be done perfectly well in user space, but I fail to
see why you couldn't do it in proc if you wanted to.

-- 
Daniel
