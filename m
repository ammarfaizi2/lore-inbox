Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWD0Vrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWD0Vrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWD0Vrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:47:53 -0400
Received: from xenotime.net ([66.160.160.81]:40648 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751710AbWD0Vrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:47:53 -0400
Date: Thu, 27 Apr 2006 14:50:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-Id: <20060427145017.f35c906f.rdunlap@xenotime.net>
In-Reply-To: <jmd2529m892ln9h8ptpp58ltq5895495nb@4ax.com>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
	<20060427121930.2c3591e0.akpm@osdl.org>
	<jmd2529m892ln9h8ptpp58ltq5895495nb@4ax.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 07:41:52 +1000 Grant Coady wrote:

> On Thu, 27 Apr 2006 12:19:30 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> >I don't like dropping patches.  Because then the thing needs to be fixed up
> >and resent and remerged and re-reviewed and rejects need to re-fixed-up and
> >this adds emailing overhead and 12-24 hour turnaround, etc.  I very much
> >prefer to hang onto the patch and get it fixed up.  This means that I
> >usually have to do the fixing-up.
> 
> Perhaps dropping patches with obvious faults with some feedback 
> to submitter may reduce your workload ;)  And is slowing down the 
> merge a little in these cases such a bad thing if it improves 
> patch quality over time?

True dat.  That's what I would do.  :)
But I seem to need more sleep than Andrew does.

---
~Randy
