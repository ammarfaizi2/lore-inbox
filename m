Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265889AbSKFR77>; Wed, 6 Nov 2002 12:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSKFR77>; Wed, 6 Nov 2002 12:59:59 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:41481 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265889AbSKFR75>; Wed, 6 Nov 2002 12:59:57 -0500
Date: Wed, 6 Nov 2002 18:07:13 +0000
To: Patrick Finnegan <pat@purdueriots.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile errors with devicemapper/2.5.46
Message-ID: <20021106180713.GA23574@reti>
References: <Pine.LNX.4.44.0211061210200.26467-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061210200.26467-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 12:16:36PM -0500, Patrick Finnegan wrote:
> When I try compiling the devicemapper as a module in 2.5.46, I get the
> following error:

Please apply the three little patches from:

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.46-dm1.tar.bz2

I'll resend them to Linus/Dave and hope they get in this time.

- Joe
