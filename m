Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272264AbRIRPmX>; Tue, 18 Sep 2001 11:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272137AbRIRPmQ>; Tue, 18 Sep 2001 11:42:16 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:6414 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272264AbRIRPl6>; Tue, 18 Sep 2001 11:41:58 -0400
Date: Tue, 18 Sep 2001 09:29:13 -0600
Message-Id: <200109181529.f8IFTDJ10734@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Giacomo Catenazzi" <cate@dplanet.ch>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: new OOPS 2.4.10-pre11, do_generic_file_read [devfs related?]
In-Reply-To: <3BA73F45.4090704@dplanet.ch>
In-Reply-To: <3BA73F45.4090704@dplanet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi writes:
> Starting in 2.4.10-pre11 I have a new oops.
> This time the oops happens also without floppy support,
> but also this bug happen at boot time, when mounting root
> rw. Also this time the oops seem reproducible.

Wow! I should try 2.4.10-pre11. I have't had a chance yet.

> devfs=nomount solve this bug (like the old bug).
> 
> What the status of your devfs rewrite ?

Only small progress: I spent last week in Boston setting up some test
boxes, which was slower than expected thanks to battling with the
non-standardness of Compaq boxen. Grrr.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
