Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264273AbRFLInU>; Tue, 12 Jun 2001 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264278AbRFLInK>; Tue, 12 Jun 2001 04:43:10 -0400
Received: from [194.213.32.142] ([194.213.32.142]:13828 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264273AbRFLIm5>;
	Tue, 12 Jun 2001 04:42:57 -0400
Message-ID: <20010611225944.B959@bug.ucw.cz>
Date: Mon, 11 Jun 2001 22:59:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>,
        linux-kernel@vger.kernel.org
Cc: demolinux@demolinux.org, dicosmo@pps.jussieu.fr
Subject: Re: [isocompr PATCH]: announcing stable port to kernel 2.2.18
In-Reply-To: <200106110929.f5B9T5Q27584@foobar.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200106110929.f5B9T5Q27584@foobar.pps.jussieu.fr>; from Roberto Di Cosmo on Mon, Jun 11, 2001 at 11:29:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Dear mailing list members,
>         you will find at http://www.pps.jussieu.fr/~dicosmo/FreeSoftware
> the first public release of my updates (for 2.2.18) of an old patch
> (due to Eric Youngdale and  Adam J. Richter) to allow the use
> of transparent compression of files on iso9660 images.
> 
> This means you can  pack over 1Gb of data on a usual CD. Also, since
>  reading off the CD is actually slower than decompressing data, an overall
> speed improvement comes as a bonus.

Good.

> The current version of the patch for 2.2.18 is very stable (we use it
> for DemoLinux [see www.demolinux.org] heavily), and I wonder if it could
> not be a good idea to see if this code can be folded into the official releases
> sometime in the future (I have been looking at 2.4.x code, but the new page
> cache means some changes might be needed: I will try to post a first version
> for 2.4.x soon).

I think that 2.5.0 should be your target... It is definitely new
feature, and both 2.4.X and 2.2.X are in feature freeze.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
