Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVAYVGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVAYVGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVAYVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:03:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19606 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262117AbVAYU7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:59:50 -0500
Subject: Re: ATI drivers working under realtime-preempt linux
From: Lee Revell <rlrevell@joe-job.com>
To: John Gilbert <jgilbert@biomail.ucsd.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41F5CF5D.4060807@biomail.ucsd.edu>
References: <41F5CF5D.4060807@biomail.ucsd.edu>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 15:59:46 -0500
Message-Id: <1106686786.10845.58.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 20:47 -0800, John Gilbert wrote:
> Xv isn't supported. DRI isn't supported.
> ATI (and NVIDIA) should be all over the hard-realtime kernel, as this 
> has the potential of making video and games frame accurate (never 
> missing frames, no page tears).
> The documentation from Linux user's web pages are better than ATI's.
> 
> Making this work should have been someone at ATI's job, not mine. I'm 
> working blind here.

Be patient, this stuff is very new and vendors are rightfully
conservative.  They are probably just waiting for the development to
settle down a bit before committing resources to supporting the RT
kernel.

Once some distros start to offer the RT kernel as an option I would
expect a lot of interest from hardware vendors as it really allows the
hardware pushed to its limits.  For example pro audio interfaces are
heavily marketed based on the lowest achievable latency, this will let
them put better numbers on the box, and will probably improve Linux
support a lot, because the marketing will have to be "FooAudio5000, now
featuring 0.6 ms*** usable latency (***Linux RT kernel required, 2.6 ms
under Windows/MacOS)" :-).

Lee

