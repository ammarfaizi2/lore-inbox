Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRC3PJ4>; Fri, 30 Mar 2001 10:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131479AbRC3PJq>; Fri, 30 Mar 2001 10:09:46 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:12297 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131478AbRC3PJ0>; Fri, 30 Mar 2001 10:09:26 -0500
Message-Id: <200103301508.f2UF8fs23706@aslan.scsiguy.com>
To: "George Bonser" <george@gator.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 aic7xxx wont compile 
In-Reply-To: Your message of "Thu, 29 Mar 2001 23:19:22 PST."
             <CHEKKPICCNOGICGMDODJOEHOCJAA.george@gator.com> 
Date: Fri, 30 Mar 2001 08:08:41 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just tried to build 2.4.3, got:

Grumble. Grumble. Grumble.

We've been through this before.  The 6.1.8 version of the
driver has a fixed Makefile, doesn't even attempt to assemble
the firmware unless you config your kernel to turn it on, and has
been out for over a month now.

I guess it will have to wait until 2.4.4.  I'll post updated
patches for 2.4.3 later today, but the ones for 2.4.3-pre6 should
apply fine.

--
Justin
