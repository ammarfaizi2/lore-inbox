Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUEZUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUEZUJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbUEZUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:09:40 -0400
Received: from grunt21.ihug.com.au ([203.109.249.141]:64153 "EHLO
	grunt21.ihug.com.au") by vger.kernel.org with ESMTP id S265785AbUEZUJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:09:37 -0400
Subject: Re: [Fwd: Re: drivers DB and id/ info registration]
From: Zenaan Harkness <zen@freedbms.net>
To: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
In-Reply-To: <20040526195505.GB2588@kroah.com>
References: <1085548092.2909.60.camel@zen8100a.freedbms.net>
	 <20040526182919.GA25978@kroah.com>
	 <1085600051.2468.17.camel@zen8100a.freedbms.net>
	 <20040526195505.GB2588@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1085602088.2466.24.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 06:08:08 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 05:55, Greg KH wrote:
> Remember, an id by itself is pointless.  We need specs and drivers that
> work for those specs.  You should concentrate on that goal instead of
> worrying about ids.

Of course there would be provision for "submit willing to code", "submit
specs" etc - a support- and interest- garnering site.

> > Perhaps users can submit some, and surely at least _some_ companies,
> > and/ or their employees, will do so too.
> > 
> > Still pointless?
> 
> As we are going to rip the pci.ids file out of the 2.7 kernel tree,
> pretty much so :)

Hmm, I guess lkml is going to be pretty well kernel-centric.

Are you saying "it'll be ripped out and discarded forever" or
"ripped out and placed in userspace where it always shoulda been"?

I'm still not convinced that having comprehensive device recognition
is pointless (but I'm not trying to push something that excludes
drivers here either ...).

ta
zen
