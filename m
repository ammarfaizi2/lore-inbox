Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVHLTbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVHLTbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVHLTbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:31:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:19399 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750757AbVHLTbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:31:15 -0400
Date: Fri, 12 Aug 2005 21:31:09 +0200
From: Olaf Hering <olh@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
Message-ID: <20050812193109.GA15434@suse.de>
References: <1.502409567@selenic.com> <20050812172151.GA11104@suse.de> <20050812192152.GJ12284@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050812192152.GJ12284@waste.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 12, Matt Mackall wrote:

> Does the task dump work without patch 5/8 (add retry timeout)? I'll
> try testing it here.

I spoke to soon, worked once, after reboot not anymore. Will try to play
with individual patches. Does the task dump work for you, at least?
