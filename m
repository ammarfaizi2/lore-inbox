Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRJWRpN>; Tue, 23 Oct 2001 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278131AbRJWRpD>; Tue, 23 Oct 2001 13:45:03 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:13663 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S278125AbRJWRou>; Tue, 23 Oct 2001 13:44:50 -0400
Date: Tue, 23 Oct 2001 19:45:13 +0200
From: Cliff Albert <cliff@oisec.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] USB, Palm M500, Coldsync
Message-ID: <20011023194513.A4759@oisec.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011023191458.A4261@oisec.net> <20011023103727.C9943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011023103727.C9943@kroah.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:37:27AM -0700, Greg KH wrote:

> > Hi,
> > 
> > Coldsync segfaults after a successful hotsync with my Palm M500 which
> > is connected using the USB Cradle. It also generates a oops. I hope
> > the following info is enough to fix this problem.
> 
> This isn't a coldsync bug :)

Just wanted the coldsync people to know about the bug :)

> A number of other people have reported this problem, and it is on my
> TODO list to fix.
> 
> Thanks for the oops trace.

No problem, i'm glad to test any patches and provide you with feedback.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
