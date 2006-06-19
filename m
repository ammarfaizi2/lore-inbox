Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWFSHKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFSHKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWFSHKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:10:31 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:15801 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751174AbWFSHKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:10:30 -0400
Message-ID: <44964D16.6060206@aitel.hist.no>
Date: Mon, 19 Jun 2006 09:07:02 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: David Miller <davem@davemloft.net>, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>	<448F0344.9000008@rtr.ca>	<448F0D4B.30201@rtr.ca> <20060613.142603.48825062.davem@davemloft.net> <448F32E1.8080002@rtr.ca>
In-Reply-To: <448F32E1.8080002@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>
> Unilaterally following the standard is all well and good
> for those who know how to get around it when a site becomes
> inaccessible, but not for Joe User.
>
So lets enable it in the kernel, and let the distros turn it off.
The Joe User who isn't a kernel hacker won't be running 2.6.17
in a long time.  He'll be running whatever his distro packages for him,
and they will know how to disable (or patch out) window scaling.

Someone who compiles his own kernel runs into all sorts of
issues, this is just one more of them.
> If it always fails, or always works, that's not such a big problem.
> I would never have complained if I had never been able to access
> the web sites in question.  But since it IS working in 2.6.16,
> and got broken in 2.6.17, I'm bloody well going to complain.
Yes.  And make sure you complain to those running the bad
box as well.

Helge Hafting
