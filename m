Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbTIOVWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTIOVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:22:38 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:65513 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261607AbTIOVWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:22:36 -0400
Date: Mon, 15 Sep 2003 14:22:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: Cort Dougan <cort@ftsoj.fsmlabs.com>, linux-kernel@vger.kernel.org,
       plm-devel@lists.sourceforge.net
Subject: Re: PowerPC Cross-compile of 2.6 kernels
Message-ID: <20030915212234.GB9102@ip68-0-152-218.tc.ph.cox.net>
References: <20030913005537.GA767@ftsoj.fsmlabs.com> <Pine.LNX.4.33.0309151318010.631-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309151318010.631-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 02:12:26PM -0700, Judith Lebzelter wrote:
> On Fri, 12 Sep 2003, Cort Dougan wrote:
> 
> > It would be nice to see the 4xx and 8xx chips being tested.  There are a
> > lot of rarely tested configurations and targets in the PPC kernel.
> 
> I could run a simpler compile filter, one compile that counts and
> prints all the errors and warnings, on these extra platforms.  Did you
> have any specific platform in mind?  40x give me 'walnut' and 8xx gives
> me 'rpx-lite' if I do 'make defconfig' followed by 'make oldconfig' where
> I set the main platform (to 40x or 8xx) and accept all the default
> options.

'Walnut' is a good 40x platform.  I wouldn't worry about 8xx right now,
however.

-- 
Tom Rini
http://gate.crashing.org/~trini/
