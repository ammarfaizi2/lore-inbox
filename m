Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUIDVRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUIDVRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIDVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:17:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:55985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266195AbUIDVRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:17:01 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: NVIDIA Driver 1.0-6111 fix
Date: Sat, 4 Sep 2004 23:22:47 +0200
User-Agent: KMail/1.7
Cc: Tim Fairchild <tim@bcs4me.com>, Christoph Hellwig <hch@infradead.org>,
       Sid Boyce <sboyce@blueyonder.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <41390988.2010503@blueyonder.co.uk> <200409041954.05272.tim@bcs4me.com> <1094327788.6575.209.camel@krustophenia.net>
In-Reply-To: <1094327788.6575.209.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409042322.50478.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so which (in this case) graphic card should we buy? i bought my nvidia card, 
because i knew that nvidia hands out linux drivers, even if they are binary 
only, but i knew that they do, so i didn't want to buy another card and 
realize afterwards that it absolutely isn't supported under linux.

regards,
dominik


On Saturday 04 September 2004 21:56, Lee Revell wrote:
> On Sat, 2004-09-04 at 05:54, Tim Fairchild wrote:
> > The nvidia module compiles fine with the non mm kernel but will
> > not compile with the mm patches for me.
>
> The nvidia module is binary-only.  You are not compiling it, AIUI the
> installer fetches the binary module from the nvidia site and builds some
> wrappers.  Even if this process were to succeed the result would almost
> certainly not work.  This is the reason you need open source software.
>
> Judging from all the tainted-kernel OOPS'es that get posted here, it
> would appear that the majority of Linux users are perfectly willing to
> buy hardware that requires binary-only drivers.  People do not seem to
> understand that there is absolutely NO incentive for vendors to open
> their source if you would buy it just the same with a binary driver!
>
> I bet 99.9% of the people who signed that stupid petition already own
> freaking ATI hardware.  The people yelling the loudest seem to be those
> who didn't realize the hardware wasn't Linux compatible when they bought
> it, when it would have taken 10 seconds to find out.  Why should they
> give you an open source driver now, when you were perfectly willing to
> buy it without one?  Because you threaten not to buy another?
> Bwahahahahaha.
>
> The only kind of democracy hardware vendors understand is voting with
> your wallet.  Personally I don't care, all the drivers I use are open
> source, but the whining is getting tiresome.
>
> Lee

