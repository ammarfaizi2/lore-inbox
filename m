Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUCKGbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUCKGbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:31:50 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:5936 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262745AbUCKGbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:31:48 -0500
Date: Wed, 10 Mar 2004 22:30:04 -0800
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311063004.GD12682@sgi.com>
Mail-Followup-To: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <200403102003.i2AK3qm16576@unix-os.sc.intel.com> <20040310202025.GH15087@suse.de> <20040310204532.GA10281@sgi.com> <20040310204936.GJ15087@suse.de> <20040310205237.GK15087@suse.de> <20040310210104.GA10406@sgi.com> <20040310210249.GM15087@suse.de> <20040310213509.GA10888@sgi.com> <20040310155419.550c4a6a.akpm@osdl.org> <16463.44267.253785.644266@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16463.44267.253785.644266@napali.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 04:03:55PM -0800, David Mosberger wrote:
> Jesse, if you want to try q-tools and need some help in getting the
> per-CPU results merged, let me know (it's something that's planned for
> a future release, but there is only so many hours in a day so this
> hasn't been done yet).

Yeah, I've been really wanting to try it out (esp. when you mentioned
that you'd be able to profile interrupt off code :).  I'll try to get
some more time on the machine and take a look.

Also, wli just informed me that I screwed up another aspect of the
profile too, the readprofile command i grabbed from the manpage (as my
time on the machine ran out) didn't output things in a very useful
order.

Thanks,
Jesse
