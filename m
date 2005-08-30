Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVH3OA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVH3OA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVH3OA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:00:29 -0400
Received: from relay01.pair.com ([209.68.5.15]:44818 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751295AbVH3OA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:00:28 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Date: Tue, 30 Aug 2005 09:00:35 -0500
User-Agent: KMail/1.8.1
References: <200508292303.52735.chase.venters@clientec.com> <9a87484905083005064cf4e6d0@mail.gmail.com>
In-Reply-To: <9a87484905083005064cf4e6d0@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300900.36148.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 07:06 am, you wrote:
> On 8/30/05, Chase Venters <chase.venters@clientec.com> wrote:
> > Greetings kind hackers...
> >         I recently switched to 2.6.13 on my desktop. I noticed that the
> > second "CPU" (is there a better term to use in this HyperThreading
> > scenario?) that used to be listed in /proc/cpuinfo is no longer present.
> > Browsing over the
>
> [snip]
>
> CONFIG_MPENTIUM4, CONFIG_SMP and CONFIG_SCHED_SMT enabled?

Yes in all three regards.

Thanks,
Chase
