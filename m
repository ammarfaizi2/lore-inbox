Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWJ1HZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWJ1HZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 03:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWJ1HZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 03:25:30 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:661 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751894AbWJ1HZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 03:25:29 -0400
Date: Sat, 28 Oct 2006 00:25:19 -0700
From: thockin@hockin.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028072519.GA12503@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <1161986902.27225.206.camel@mindpipe> <1162007907.26022.13.camel@localhost.localdomain> <200610272106.13115.ak@suse.de> <20061028063524.GA7669@hockin.org> <20061027234615.791b3942.akpm@osdl.org> <20061028064924.GA9127@hockin.org> <20061028001316.928e85e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028001316.928e85e8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 12:13:16AM -0700, Andrew Morton wrote:
> > > http://lkml.org/lkml/2006/7/22/104
> > 
> > Nothing at all, or just the the low few bits are writeable?
> 
> We don't know - the tsc sync code doesn't remeasure the errors after "correcting"
> them.

I read the thread.  Just as a challenge, I'd love to poke at such a
system, but I doubt very much I'll get the chance :)

Tim
