Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbRHGQCu>; Tue, 7 Aug 2001 12:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbRHGQCk>; Tue, 7 Aug 2001 12:02:40 -0400
Received: from weta.f00f.org ([203.167.249.89]:22417 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268974AbRHGQC3>;
	Tue, 7 Aug 2001 12:02:29 -0400
Date: Wed, 8 Aug 2001 04:03:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: David Maynor <david.maynor@oit.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
Message-ID: <20010808040326.G26290@weta.f00f.org>
In-Reply-To: <5.1.0.14.2.20010807103637.00a88b60@pop.prism.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010807103637.00a88b60@pop.prism.gatech.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 10:37:57AM -0400, David Maynor wrote:

    This is a should-if debate, in my opinion. That is, not if you can
    do it, but should you. Has anybody thought of the performance hit
    that you would take encrypting your swap?

Yes, and people have written papers about it.


If you use hardware, the difference is insignificant.  In software,
it's measurable (maybe a 30% hit) but still quite acceptable. See the
Usenix Security Symposium Proceedings for 2000 (I'm too lazy to find
the paper myself).



  --cw
