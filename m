Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVI2Px0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVI2Px0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2Px0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:53:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932147AbVI2PxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:53:25 -0400
Date: Thu, 29 Sep 2005 08:52:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 0/3] GDT alignment fixes
In-Reply-To: <200509282140.j8SLelHR032216@zach-dev.vmware.com>
Message-ID: <Pine.LNX.4.58.0509290851370.3308@g5.osdl.org>
References: <200509282140.j8SLelHR032216@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just fyi, 
 I'll leave this until after 2.6.14, since it doesn't seem to be that 
pressing. Can you re-send after the release (preferably with the relevant 
people having signed-off on it or at least added their "acked-by" lines?)

		Linus
