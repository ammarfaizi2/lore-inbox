Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWD0U6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWD0U6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWD0U6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:58:55 -0400
Received: from xenotime.net ([66.160.160.81]:35207 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751662AbWD0U6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:58:54 -0400
Date: Thu, 27 Apr 2006 14:01:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Message-Id: <20060427140119.67381642.rdunlap@xenotime.net>
In-Reply-To: <44512EF0.2090700@ppp0.net>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
	<20060427121930.2c3591e0.akpm@osdl.org>
	<200604272126.30683.ak@suse.de>
	<20060427124452.432ad80d.rdunlap@xenotime.net>
	<20060427131100.05970d65.akpm@osdl.org>
	<44512EF0.2090700@ppp0.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 22:52:00 +0200 Jan Dittmer wrote:

> Andrew Morton wrote:
> > Adrian does some of the other steps.  I'm not aware of anyone who is doing
> > regular sparse and kernel-doc checking on -mm.
> 
> Sparse checks are in the results at http://l4x.org/k/ . There is just
> someone missing who looks at the results :(

Thanks for reminding us of the URL.

If someone wants to try to fix those, they still should verify
their patches with gcc & sparse, of course.

And we've seen that problem of not looking at the results before.  :(

---
~Randy
