Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbRCaAhl>; Fri, 30 Mar 2001 19:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRCaAhb>; Fri, 30 Mar 2001 19:37:31 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:42306 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131772AbRCaAhQ>; Fri, 30 Mar 2001 19:37:16 -0500
Date: Fri, 30 Mar 2001 18:36:28 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Scott G. Miller" <scgmille@indiana.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu>
Message-ID: <Pine.LNX.3.96.1010330183527.2119D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Scott G. Miller wrote:
> Linux 2.4.3, Debian Woody.  2.4.2 works without problems.  However, in
> 2.4.3, pcnet32 loads, gives an error message:

hrm, can you try 2.4.2-acXX as well?

I pretty much just merged pcnet32 patches from there.

I should be getting a pcnet32 test card on Tuesday, maybe I can knock
out the bug and avoid having to revert the merge.

Regards,

	Jeff



