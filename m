Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUH1SIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUH1SIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUH1SIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:08:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29352 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267486AbUH1SIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:08:45 -0400
Subject: Re: reverse engineering pwcx
From: Lee Revell <rlrevell@joe-job.com>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       clemtaylor@comcast.net, qg@biodome.org, rogers@isi.edu
In-Reply-To: <1093716249.8611.45.camel@krustophenia.net>
References: <1093709838.434.6797.camel@cube>
	 <1093710358.8611.22.camel@krustophenia.net>
	 <Pine.LNX.4.61.0408281039470.16039@twin.uoregon.edu>
	 <1093716249.8611.45.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093716530.8611.47.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 14:08:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 14:04, Lee Revell wrote:
> On Sat, 2004-08-28 at 13:53, Joel Jaeggli wrote:
> > On Sat, 28 Aug 2004, Lee Revell wrote:
> > >
> > > How do you account for the Slashdot poster's assertion that it's
> > > physically impossible to cram 640 x 480 worth of data down a USB 1.1
> > > pipe?
> > 
> > 640x480 = 307200 pixels
> > x 24 bits = 7372800 bits per frame (.9MB)
> > x 30 fps = 221184000
> > 
> > so that's 221mb/s for uncompressed 640x480. dv with 16bit pcm is 25Mb/s 
> > typically which is still a bit more than double what you can reasonably 
> > push through a usb1.1 port. raw you can push about 1.6 fp/s at 640x480 
> > through usb so your compression ratio needs to be order of 15 to 1 make 
> > it fit reasonably with room for overhead.
> 
> 15 to 1 is impossible without lossy compression.

Disregard, Vojtech's post clears things up.

Lee

