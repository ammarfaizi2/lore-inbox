Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTIEEKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 00:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIEEKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 00:10:06 -0400
Received: from adsl-64-175-243-181.dsl.sntc01.pacbell.net ([64.175.243.181]:6413
	"EHLO top.worldcontrol.com") by vger.kernel.org with ESMTP
	id S262068AbTIEEKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 00:10:01 -0400
From: brian@worldcontrol.com
Date: Thu, 4 Sep 2003 21:13:16 -0700
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Message-ID: <20030905041316.GA1886@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 08:25:38AM -0700, Patrick Mochel wrote:
> No, you have to understand that I don't want to call software_suspend() at 
> all. You've made the choice not to accept the swsusp changes, so we're 
> forking the code. We will have competing implementations of 
> suspend-to-disk in the kernel. 

And the fork happened in 2.6.0-test4?

Some how I thought the 6, being even, meant stable.

I am at a complete loss how these test3 to test4 major changes
that broke everything meet with the often repeated definitions
of how kernel development is to be accomplished.

Perhaps I missed something, development kernels include all
odd numbers and 6?

-- 
Brian Litzinger
