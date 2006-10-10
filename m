Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWJJVh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWJJVh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWJJVh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:37:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52691 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030456AbWJJVh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:37:27 -0400
Date: Tue, 10 Oct 2006 14:36:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: torvalds@osdl.org, massad@gmail.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org, hc@mivu.no, dtor@mail.ru
Subject: Re: [PATCH] itmtouch: fix inverted flag to indicate touch location
 correctly
Message-Id: <20061010143636.9ce38722.pj@sgi.com>
In-Reply-To: <20061004204114.e2906ead.rdunlap@xenotime.net>
References: <7f9863480610041736k2fe84c6bqd1d9740868dedf7d@mail.gmail.com>
	<Pine.LNX.4.64.0610041913050.3952@g5.osdl.org>
	<20061004204114.e2906ead.rdunlap@xenotime.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy, commenting on a patch of Mark Assad <massad@gmail.com>:
>
> Sure, if you use SMTP to gmail instead of the web interface.
> The web interface isn't decent for sending patches.


If you're going that route, another option is to use my sendpatchset
utility:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

It has hooks (read the code - it's a script) for directly feeding
patches to the gmail SMTP agent.  See the embedded usage statement
for instructions on using it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
