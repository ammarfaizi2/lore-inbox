Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWEPOkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWEPOkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEPOkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:40:46 -0400
Received: from unthought.net ([212.97.129.88]:40465 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751160AbWEPOkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:40:45 -0400
Date: Tue, 16 May 2006 16:40:44 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
Message-ID: <20060516144044.GJ15032@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Steven Rostedt <rostedt@goodmis.org>, Marc Perkel <marc@perkel.com>,
	linux-kernel@vger.kernel.org
References: <4469D296.8060908@perkel.com> <Pine.LNX.4.58.0605160939290.10890@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605160939290.10890@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 09:48:25AM -0400, Steven Rostedt wrote:
...
> > So what about Linux? With thousands of people working on the Kernel if
> > someone from the NSA wanted to slip a back door into the Kernel, could
> > the do that?
> 
> Well, yes and no.
> 
...
> There's so much free stuff out there, that people download and install
> blindly, that I'm sure if someone wanted to really badly, they could get
> it on some boxes.  If they were slime and added something to a binary,
> and supplied the source without the backdoor, that might last a while.
> Unless you compile everything yourself, it's not easy to make sure that
> all binaries came from the source you have.

Read "Reflections on Trusting Trust" to see why compiling things from
source gets you absolutely *zero* extra security in this regard.

http://www.acm.org/classics/sep95/

-- 

 / jakob

