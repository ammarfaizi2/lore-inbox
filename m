Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVLCT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVLCT5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVLCT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:57:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5346 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750930AbVLCT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:57:49 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051203193538.GM31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 14:57:11 -0500
Message-Id: <1133639835.16836.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 20:35 +0100, Adrian Bunk wrote:
> 
> But yes, what I suggest is partially a step back in a way that it 
> doesn't conflict with the current 2.6.17+ development model.
> 
> Well, if taking the best from the old style development is improving 
> things that isn't something bad. 

You seem to be saying that the current development model is unacceptable
for users for whom older kernel work just fine, and the main risk in
upgrading is regression.  But the new development model is clearly
needed for those users whose needs are not met by the old kernel, say
due to unacceptable soft RT performance or unsupported hardware.

But it's wrong to try to evenly balance the needs of these two classes
of users, because the first class has another option - they can stick
with the old kernel that works for them.  The second class of users has
no other option, so their needs should be given greater weight.

Lee

