Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVCOTR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVCOTR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVCOTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:13:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1164 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261785AbVCOTIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:08:36 -0500
Date: Tue, 15 Mar 2005 11:06:32 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: mpm@selenic.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH][1/2] SquashFS
Message-Id: <20050315110632.07fc8d09.pj@engr.sgi.com>
In-Reply-To: <42370B14.50608@lougher.demon.co.uk>
References: <4235BAC0.6020001@lougher.demon.co.uk>
	<20050315003802.GH3163@waste.org>
	<42363EAB.3050603@yahoo.com.au>
	<20050315004759.473f6a0b.pj@engr.sgi.com>
	<42370442.7020401@lougher.demon.co.uk>
	<20050315172724.GO32638@waste.org>
	<42370B14.50608@lougher.demon.co.uk>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Shouldn't issues like this be in the coding style document?

There is not a concensus (nor a King Penguin dictate) between the
"while(1)" and "for(;;)" style to document.  If this were a
frequently asked question, I suppose someone would eventually
note in a coding style doc that either style is acceptable.


> It's a shame the 'rather trivial' issue got picked up in the first place 

Not a shame at all.  Such coding style issues are well known to be a
proper subject for discussion here.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
