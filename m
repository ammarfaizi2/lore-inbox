Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269212AbUIHXnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269212AbUIHXnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUIHXnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:43:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19652 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269212AbUIHXnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:43:05 -0400
Date: Thu, 9 Sep 2004 09:42:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040909094255.F3951028@wobbly.melbourne.sgi.com>
References: <20040908123524.GZ390@unthought.net> <20040909074046.A3958243@wobbly.melbourne.sgi.com> <20040908232210.GL390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040908232210.GL390@unthought.net>; from jakob@unthought.net on Thu, Sep 09, 2004 at 01:22:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

On Thu, Sep 09, 2004 at 01:22:11AM +0200, Jakob Oestergaard wrote:
> On Thu, Sep 09, 2004 at 07:40:47AM +1000, Nathan Scott wrote:
> > > ...
> > > trivial-to-trigger bugs that crash the system and have simple fixes,
> > > have not been fixed in current mainline kernels.
> > 
> > If you have trivial-to-trigger bugs (or other bugs) then please let
> > the folks at linux-xfs@oss.sgi.com know all the details (test cases,
> > etc, are quite useful).
> 
> They've known for 7 months (bug 309 in your bugzilla), but the problem
> is still trivially triggered in 2.6.8.1.
> 

OK, so could you add the details on how you're managing to hit it
into that bug?... when you say "trivially" - does that mean you
have a recipe that is guaranteed to quickly hit it?  A reproducible
test case would be extremely useful in tracking this down.

thanks.

-- 
Nathan
