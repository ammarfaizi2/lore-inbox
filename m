Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVJaIUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJaIUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJaIUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:20:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29614 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750801AbVJaIUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:20:22 -0500
Date: Mon, 31 Oct 2005 00:19:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: akpm@osdl.org, ak@suse.de, tytso@mit.edu, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051031001950.62dc7a18.pj@sgi.com>
In-Reply-To: <20051031072714.GU7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<p73r7a4t0s7.fsf@verdi.suse.de>
	<20051030213221.GA28020@thunk.org>
	<200510310145.43663.ak@suse.de>
	<20051031001810.GQ7992@ftp.linux.org.uk>
	<20051030191402.669273d5.pj@sgi.com>
	<20051031033426.GT7992@ftp.linux.org.uk>
	<20051030232234.3ebf77c8.akpm@osdl.org>
	<20051031072714.GU7992@ftp.linux.org.uk>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> I do cross-builds for allmodconfig on a *lot* more targets than what you've
> mentioned

Apples to oranges, and half full versus half empty.

If Al is testing combinations that Andrew doesn't regularly test,
then Al might expect to find problems that Andrew didn't find.

Non-specific complaints that make it all sound too hard are
not particularly constructive.  But then Al was trying for the
"particularly constructive" achievement award of the day ;).

I find that the defconfig crosstool builds of *-mm more or less always
work for the popular configurations.  That meets my needs just fine.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
