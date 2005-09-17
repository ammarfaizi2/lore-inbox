Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVIQAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIQAFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIQAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:05:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13533
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750807AbVIQAFO (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 16 Sep 2005 20:05:14 -0400
Date: Fri, 16 Sep 2005 17:05:11 -0700 (PDT)
Message-Id: <20050916.170511.109703537.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 4/5] atomic: dec_and_lock use cmpxchg
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43285538.1090709@yahoo.com.au>
References: <432839F1.5020907@yahoo.com.au>
	<20050914.092441.87955714.davem@davemloft.net>
	<43285538.1090709@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 15 Sep 2005 02:52:08 +1000

> OK that's fair enough. I'll submit whatever cleanups are possible
> on top of your patch after the atomic_cmpxchg patch goes in (if
> it goes in). Thanks.

The updated patch is in Linus's current tree, FYI.
The GIT commit is: 4db2ce0199f04b6e99999f22e28ef9a0ae5f0d2f
