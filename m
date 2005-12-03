Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVLCXuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVLCXuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLCXuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:50:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21133 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932179AbVLCXuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:50:17 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203225815.GH25722@merlin.emma.line.org>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe>
	 <20051203225815.GH25722@merlin.emma.line.org>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 18:49:41 -0500
Message-Id: <1133653782.19768.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 23:58 +0100, Matthias Andree wrote:
> On Sat, 03 Dec 2005, Lee Revell wrote:
> 
> > You seem to be saying that the current development model is unacceptable
> > for users for whom older kernel work just fine, and the main risk in
> > upgrading is regression.  But the new development model is clearly
> > needed for those users whose needs are not met by the old kernel, say
> > due to unacceptable soft RT performance or unsupported hardware.
> > 
> > But it's wrong to try to evenly balance the needs of these two classes
> > of users, because the first class has another option - they can stick
> > with the old kernel that works for them.  The second class of users has
> 
> The point that just escaped you as the motivation for this thread was
> the availability of security (or other critical) fixes for older
> kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
> available for those who find 2.6.8 works for them (the fix went into
> 2.6.14 BTW), and the concern is the development model isn't fit to
> accomodate needs like this.
> 

If you want security fixes backported then you can get a distro kernel.

Lee

