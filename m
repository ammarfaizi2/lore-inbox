Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUIBUMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUIBUMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUIBUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:11:56 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:13701 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268928AbUIBUEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:04:51 -0400
Date: Thu, 2 Sep 2004 13:04:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902200403.GA6875@taniwha.stupidest.org>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <20040902194909.GA8653@atrey.karlin.mff.cuni.cz> <1094155277.11364.92.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094155277.11364.92.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 04:01:17PM -0400, Lee Revell wrote:

> Better to have the contents accessible via a separate stream, in the
> same namespace.  Fix it once in the kernel vs. fix it in umpteen
> apps.

This is ridiculous.  We have shared libraries, 99% of applications
manage to use libc for example --- this isn't that different.


  --cw
