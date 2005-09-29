Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVI2S5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVI2S5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVI2S5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:57:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbVI2S5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:57:37 -0400
Date: Thu, 29 Sep 2005 11:57:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 0/3] GDT alignment fixes
Message-ID: <20050929185713.GK16352@shell0.pdx.osdl.net>
References: <200509282140.j8SLelHR032216@zach-dev.vmware.com> <Pine.LNX.4.58.0509290851370.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509290851370.3308@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> Just fyi, 
>  I'll leave this until after 2.6.14, since it doesn't seem to be that 
> pressing. Can you re-send after the release (preferably with the relevant 
> people having signed-off on it or at least added their "acked-by" lines?)

I'll just queue it up with the rest of the stuff in the virt tree.

thanks,
-chris
