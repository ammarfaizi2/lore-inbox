Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbTAQWIl>; Fri, 17 Jan 2003 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAQWIl>; Fri, 17 Jan 2003 17:08:41 -0500
Received: from BELLINI.MIT.EDU ([18.62.3.197]:30468 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id <S261686AbTAQWIk>;
	Fri, 17 Jan 2003 17:08:40 -0500
From: ghugh Song <ghugh@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20: More INFO
Message-Id: <20030117221726.2E4CF26D21@bellini.mit.edu>
Date: Fri, 17 Jan 2003 17:17:26 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anthony Lau (anthony@greyweasel.com) wrote:

> It took awhile for the next oops to appear. I modifed my boot
> procedure by turning off swap with "swapoff -a" and allowed the
> system to run. I waited until all of my 1.5GB of physical RAM was
> allocated (cached or in use), and let the system to contiue to
> run. The system ran stably for 2 days with normal use. I then
> switch swap back on with "swapon -a".

Well.  In my case, I tried without swap enabled.
It still crashed when I issued "tar cf usr.tar /usr"

Regards,

G. H. S.
