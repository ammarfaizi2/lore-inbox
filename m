Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJaA4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJaA4w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUJaA4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:56:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:21436 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261451AbUJaA4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:56:51 -0400
Date: Sun, 31 Oct 2004 02:53:13 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Message-ID: <20041031005313.GD19396@wotan.suse.de>
References: <200410291823.34175.rjw@sisk.pl> <200410301742.33433.rjw@sisk.pl> <20041030155252.GA11515@wotan.suse.de> <200410301837.25828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410301837.25828.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 06:37:25PM +0200, Rafael J. Wysocki wrote:
> On Saturday 30 of October 2004 17:52, Andi Kleen wrote:
> > > Have you tested this on an SMP machine?  Mine is a UP.  I'll chek a dual 
> > 
> > Yes, on a Dual Opteron with web browsing.  Similar with firefox.
> 
> Can you, please, send me your .config?

arch/x86_64/defconfig as always.

-Andi
