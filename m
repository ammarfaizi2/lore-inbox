Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUBZCUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUBZCUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:20:33 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:49292 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S262604AbUBZCUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:20:23 -0500
Date: Wed, 25 Feb 2004 11:14:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] Distributed mmap API
Message-ID: <20040225191416.GE1397@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <200402211400.16779.phillips@arcor.de> <20040222233911.GB1311@us.ibm.com> <200402251604.19040.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402251604.19040.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 04:04:19PM -0500, Daniel Phillips wrote:
>
> I'd like to take this opportunity to apologize to Paul for derailing his more
> modest proposal, but unfortunately, the semantics that could be obtained that
> way are fatally flawed: private mmaps just won't work.  What I've written here
> is about the minimum that supports acceptable mmap semantics.

No problem -- it looks like we are getting a much better result than
I was proposing, thank you for helping me to see the light!

						Thanx, Paul
