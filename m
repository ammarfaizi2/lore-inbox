Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTE0Uwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTE0Uwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:52:38 -0400
Received: from holomorphy.com ([66.224.33.161]:31978 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264151AbTE0Uwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:52:35 -0400
Date: Tue, 27 May 2003 14:05:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527210518.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	manish <manish@storadinc.com>,
	Christian Klose <christian.klose@freenet.de>
References: <3ED2DE86.2070406@storadinc.com> <200305272032.03645.m.c.p@wolk-project.de> <20030527201028.GJ3767@dualathlon.random> <200305272224.22567.m.c.p@wolk-project.de> <20030527205516.GZ845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527205516.GZ845@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:55:16PM +0200, Jens Axboe wrote:
> But still, why on earth waste your time with something like this now
> when we are so close to 2.6? 2.4 is a stable code base, it should stay
> that way. I'm really not interested in more esoteric 2.4 backports, the
> vendor kernels are bad enough as it is.

They've backported everything else, so I guess it stood to reason it'd
happen eventually.

I, for one, got a good laugh out of it. =) Makes me wonder if the 2.4
distro backport trees' diffs are bigger than 2.4 itself yet.


-- wli
