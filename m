Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTBSXbj>; Wed, 19 Feb 2003 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBSXbj>; Wed, 19 Feb 2003 18:31:39 -0500
Received: from tapu.f00f.org ([202.49.232.129]:26256 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262446AbTBSXbi>;
	Wed, 19 Feb 2003 18:31:38 -0500
Date: Wed, 19 Feb 2003 15:41:42 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030219234142.GB22254@f00f.org>
References: <20030218194351.A23525@twiddle.net> <Pine.LNX.4.44.0302182115500.1923-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302182115500.1923-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:16:35PM -0800, Linus Torvalds wrote:

> Some people are still using 2.95, I think anything past that is long
> since unsupported and not worth worrying about.

I've recently started using 3.2 for testing and it seems, thus far, so
worse than 2.95.x and appears to have fewer bugs in some regards
(i.e. don't seem to go bonkers with register pressure form long long).

At some point, 2.95.x might be considered too old and gcc 3.2+ with
have to be the minimum --- is this time near?

What about MIPS and Sparc64 --- are they still using ancient
compilers?



  --cw
