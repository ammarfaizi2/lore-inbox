Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTHOUxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTHOUxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:53:20 -0400
Received: from 64.221.211.204.ptr.us.xo.net ([64.221.211.204]:23444 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S270822AbTHOUxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:53:15 -0400
Subject: Re: Centrino support
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2oeyq3bi2.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
	 <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
	 <m2oeyq3bi2.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Message-Id: <1060980793.29086.21.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 13:53:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 13:35, Jan Rychter wrote:

> I keep dreaming about the day when I'll be able to have a modern laptop
> with a stable Linux kernel. As for now, it has taken me (on one of my
> laptops) about 1.5 years to get to a point where 2.4 works, most of my
> hardware works, and software suspend (pretty much a requirement for
> laptops) works. I'm not about to give that up easily, so I'm not that
> eager to jump to 2.5/2.6.

Can't say that's been my experience.  I bought a new Thinkpad X31 the
other day, and it's already running 2.6.0-test3.  Suspend works, all's
happy.


> 1. Will cpufreq make it into the standard 2.4 kernels?

Highly unlikely.

> 3. Where does one get 2.4 cpufreq?

There are snapshots available at www.linux.org.uk (hint: Google for
"cpufreq"), or in -ac.  See the cpufreq mailing list archives for a
bunch of daemons that control this stuff in various semi-cooked ways.

	<b

