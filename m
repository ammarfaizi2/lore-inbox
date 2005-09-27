Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVI0ITa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVI0ITa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVI0ITa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:19:30 -0400
Received: from ns.suse.de ([195.135.220.2]:38577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964830AbVI0ITa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:19:30 -0400
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: Fw: Re: 2.6.14-rc2-mm1 ide problems on AMD64
Date: Tue, 27 Sep 2005 10:19:13 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20050926151149.6332c94e.akpm@osdl.org> <1127798272.16275.40.camel@dyn9047017102.beaverton.ibm.com>
In-Reply-To: <1127798272.16275.40.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271019.14243.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 September 2005 07:17, Badari Pulavarty wrote:

> Finally, tracked the problem causing patch in -mm tree.
> Its,
>
> x86_64-no-idle-tick.patch
>
> I backed out the patch and my machine works fine.

Boot message please.

Did you enable CONFIG_NO_IDLE_TICK? 

-Andi
