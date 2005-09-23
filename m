Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVIWNQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVIWNQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 09:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVIWNQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 09:16:46 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:55245
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S1750968AbVIWNQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 09:16:46 -0400
Date: Fri, 23 Sep 2005 09:19:20 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPF Using Quickcam
Message-ID: <20050923131920.GA15582@kurtwerks.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20050923043201.GA14899@kurtwerks.com> <20050923125724.GA11425@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923125724.GA11425@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 05:57:25AM -0700, Greg KH took 25 lines to write:
> On Fri, Sep 23, 2005 at 12:32:01AM -0400, Kurt Wall wrote:
> > 
> > I was testing out my spiffy new (to me) QuickCam Express webcam, pressed
> > ^C to terminate the test, and got the GPF shown below. Kernel version
> > is 2.6.12.3 running on SLAMD64:
> > 
> > The driver specifics are:
> > 
> > quickcam: QuickCam USB camera found (driver version QuickCam USB 0.6.3 $Date: 2005/04/15 19:32:49 $)
> > quickcam: Kernel:2.6.13.1 bus:3 class:FF subclass:FF vendor:046D product:0870
> > quickcam: Sensor HDCS-1020 detected
> > quickcam: Registered device: /dev/video1
> 
> I don't see this driver in the main kernel tree.  Where did you get it
> from?

http://qce-ga.sourceforge.net/

Now that I think about it, I suppose I shouldn't complain to LKML since 
this driver isn't in the kernel. There's a list over there, too. Sorry
to waste everyone's time. Geez; think twice, post once.

Kurt
-- 
Be free and open and breezy!  Enjoy!  Things won't get any better so
get used to it.
