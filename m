Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318095AbSGMFOk>; Sat, 13 Jul 2002 01:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318096AbSGMFOj>; Sat, 13 Jul 2002 01:14:39 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:27401 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S318095AbSGMFOi>; Sat, 13 Jul 2002 01:14:38 -0400
Date: Fri, 12 Jul 2002 22:16:21 -0700
To: Daniel Phillips <phillips@arcor.de>
Cc: Christian Ludwig <cl81@gmx.net>, Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
Message-ID: <20020713051621.GA9581@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Christian Ludwig <cl81@gmx.net>,
	Ville Herva <vherva@niksula.hut.fi>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi> <002601c228ab$86b235e0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SheA-0002Uh-00@starship>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 07:22:29PM +0200, Daniel Phillips wrote:
> On Thursday 11 July 2002 09:21, Christian Ludwig wrote:
> > Putting in another 4MB into that machine (thus it has 8MB now), made the
> > kernel boot, but ramdisk decompression failed. All in all you will need at
> > least 12MB to boot correctly, if you are using a bz2bzImage of about 700kB
> > and a 2MB compressed ramdisk image.
> 
> Good stuff, but why take this opportunity to make an ugly name even uglier?
> How about bz2Image, or, more natural in my mind, bz2linux.

Dare I say it... "linux.bz2"?  Why are Linux images so special?
After all, the first Unix kernel images were just called "unix".

cheerfully,
miket
