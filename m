Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUCTCjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 21:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUCTCjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 21:39:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:28810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263202AbUCTCjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 21:39:11 -0500
Date: Fri, 19 Mar 2004 18:39:06 -0800
From: Mark Wong <markw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040319183906.I8594@osdlab.pdx.osdl.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403181737.i2IHbCE09261@mail.osdl.org> <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de> <20040318191530.34e04cb2.akpm@osdl.org> <20040318194150.4de65049.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040318194150.4de65049.akpm@osdl.org>; from akpm@osdl.org on Thu, Mar 18, 2004 at 07:41:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 07:41:50PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Mark, if it's OK I'll run up some kernels for you to test.
> 
> At
> 
> 	http://www.zip.com.au/~akpm/linux/patches/markw/

Ok, looks like I take the first hit with the 02 patch.  Here's re-summary:

kernel          16 kb   32 kb   64 kb   128 kb  256 kb  512 kb
2.6.3                           2308    2335    2348    2334
2.6.4-mm2       2028    2048    2074    2096    2082    2078
2.6.5-rc1-01                                            2394
2.6.5-rc1-02                                            2117
2.6.5-rc1-mm2                                           2036
