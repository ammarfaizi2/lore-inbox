Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWJ1Gfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWJ1Gfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWJ1Gfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:35:33 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:63872 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751093AbWJ1Gfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:35:33 -0400
Date: Fri, 27 Oct 2006 23:35:24 -0700
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028063524.GA7669@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <1161986902.27225.206.camel@mindpipe> <1162007907.26022.13.camel@localhost.localdomain> <200610272106.13115.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610272106.13115.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 09:06:12PM -0700, Andi Kleen wrote:
> 
> > So far, has I can understand. Seems to me that my computer which have a
> > Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
> > with the patch of hrtimers on
> 
> Intel systems (except for some large highend systems) have synchronized TSCs. 

Does Intel guarantee that, or is that just what we happen to see, so far.
