Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGaTur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGaTur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 15:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGaTur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 15:50:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1234 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261451AbUGaTuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 15:50:46 -0400
Date: Sat, 31 Jul 2004 15:54:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm1
In-Reply-To: <20040731114714.37359c2d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407311519490.4095@montezuma.fsmlabs.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
 <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
 <20040731114714.37359c2d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> >
> > Ingo i believe you have a patch for this, could you push it to Andrew?
>
> I suspect Ingo's patch will be livelockable under some circumstances.
> I suspect mine is too, only less so.
>
> > I reckon it's provoked by CONFIG_PREEMPT.
>
> This should fix.

Thanks that took care of it.
