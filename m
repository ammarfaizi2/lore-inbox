Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUBSVCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267305AbUBSVCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:02:54 -0500
Received: from ns.suse.de ([195.135.220.2]:16019 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267302AbUBSVCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:02:45 -0500
Date: Fri, 20 Feb 2004 20:29:14 +0100
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-Id: <20040220202914.40ef613b.ak@suse.de>
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EB8BD@scsmsx402.sc.intel.com>
References: <9AB83E4717F13F419BD880F5254709E5011EB8BD@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 12:45:19 -0800
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> > > After #if 0 out some parts to make it compile, it fails to 
> > boot with no
> > > output at all. Sorry, don't have low level debugging or 
> > serial console on 
> > > this machine configured, let me know if you need further 
> > information.
> > 
> > It works for me with this patch both UP and SMP. Maybe you 
> > commented out 
> > too much? 
> > 
> > -Andi
> 
> Andi, Appended patch should fix the problem reported by Tony.

Which change exactly is supposed to fix it? And why? 

For me the UP kernel boots just fine.

-Andi

 
