Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUIDT4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUIDT4X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUIDT4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:56:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6855 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265974AbUIDT4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:56:21 -0400
Subject: Re: NVIDIA Driver 1.0-6111 fix
From: Lee Revell <rlrevell@joe-job.com>
To: Tim Fairchild <tim@bcs4me.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sid Boyce <sboyce@blueyonder.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409041954.05272.tim@bcs4me.com>
References: <41390988.2010503@blueyonder.co.uk>
	 <20040904103601.D13149@infradead.org>  <200409041954.05272.tim@bcs4me.com>
Content-Type: text/plain
Message-Id: <1094327788.6575.209.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 15:56:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 05:54, Tim Fairchild wrote:
> The nvidia module compiles fine with the non mm kernel but will 
> not compile with the mm patches for me.

The nvidia module is binary-only.  You are not compiling it, AIUI the
installer fetches the binary module from the nvidia site and builds some
wrappers.  Even if this process were to succeed the result would almost
certainly not work.  This is the reason you need open source software. 

Judging from all the tainted-kernel OOPS'es that get posted here, it
would appear that the majority of Linux users are perfectly willing to
buy hardware that requires binary-only drivers.  People do not seem to
understand that there is absolutely NO incentive for vendors to open
their source if you would buy it just the same with a binary driver!  

I bet 99.9% of the people who signed that stupid petition already own
freaking ATI hardware.  The people yelling the loudest seem to be those
who didn't realize the hardware wasn't Linux compatible when they bought
it, when it would have taken 10 seconds to find out.  Why should they
give you an open source driver now, when you were perfectly willing to
buy it without one?  Because you threaten not to buy another? 
Bwahahahahaha.

The only kind of democracy hardware vendors understand is voting with
your wallet.  Personally I don't care, all the drivers I use are open
source, but the whining is getting tiresome.

Lee

