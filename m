Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTEQShp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTEQShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 14:37:45 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:22928 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S261757AbTEQSho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 14:37:44 -0400
Date: Sat, 17 May 2003 11:50:37 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Nuno Monteiro <nuno@itsari.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: ioperm bitmap stuff for 2.4
Message-ID: <20030517185037.GA2411@ip68-101-124-193.oc.oc.cox.net>
References: <20030517181218.GA4000@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517181218.GA4000@hobbes.itsari.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 07:12:18PM +0100, Nuno Monteiro wrote:
> [ let's see if three is the charm, the two previous attempts didnt make 
> it to the list... ]

Seems like it. :)

> Hi people,
> 
> 
> Is the ioperm patch necessary in 2.4 also? The fix by Brian Gerst was 
> commited to the 2.5 branch 
> (http://marc.theaimsgroup.com/?l=bk-commits-head&m=105275597307968&w=2) 
> some days ago, and as of yesterday vendors are starting to ship a similar 
> fix to their kernels, so I suppose it is indeed necessary. What about the 
> attached patch? It applies to both 2.4.20 and .21-rc2, please review.
> 
> 
> (Please forgive me if this has been discussed before, I did a quick 
> search of the lkml archives and couldnt find anything relevant to 2.4)

Yeah, I couldn't find any discussion of 2.4 either. So for my own
kernels I pulled a patch out of Red Hat's kernels, and it looks
*exactly* like your patch.

-Barry K. Nathan <barryn@pobox.com>
