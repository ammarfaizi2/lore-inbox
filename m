Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031147AbWKQFFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031147AbWKQFFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031120AbWKQFFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:05:35 -0500
Received: from ns.suse.de ([195.135.220.2]:6065 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031147AbWKQFFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:05:34 -0500
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Fri, 17 Nov 2006 06:05:19 +0100
User-Agent: KMail/1.9.5
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061116145313.d7b2240b.akpm@osdl.org>
In-Reply-To: <20061116145313.d7b2240b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170605.19360.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andi seems to have merged this patch but from somewhere I picked up a
> different version, below.
> 
> I think the version I have is better.  Because the patch Andi has merged is
> cast in terms of "irq testing", which is broad.  But that's not what the
> patch does - the patch handles only timers.

Agreed. I updated to your version now.

-Andi
