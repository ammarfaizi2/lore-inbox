Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752364AbWJ0UlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbWJ0UlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbWJ0UlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:41:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24770 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752364AbWJ0UlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:41:21 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610271335.10178.ak@suse.de>
References: <1161969308.27225.120.camel@mindpipe>
	 <200610271335.10178.ak@suse.de>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 16:41:22 -0400
Message-Id: <1161981682.27225.184.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 13:35 -0700, Andi Kleen wrote:
> > What are the chances of Linux getting a similar fix?
> 
> Fix isn't the right word i would use for this particular implementation.

What exactly does that AMD patch do?  Other OS users report that it
makes TSC usable for timing again.  Does it do something really heavy
handed like disable power management features?

Lee

