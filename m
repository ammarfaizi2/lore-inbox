Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTEOSgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTEOSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:36:03 -0400
Received: from holomorphy.com ([66.224.33.161]:27600 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264156AbTEOSgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:36:02 -0400
Date: Thu, 15 May 2003 11:44:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.5 kernels fail to start second CPU
Message-ID: <20030515184445.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <20030515101103.GP8978@holomorphy.com> <Pine.LNX.3.96.1030515141540.30631I-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030515141540.30631I-100000@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 02:21:10PM -0400, Bill Davidsen wrote:
> While you are (somewhat) on the topic of starting processors, I want to
> benchmark and application on a dual Xeon system. I want to try these
> configurations, preferably without opening the box, since it's in
> another time zone.
>   2 cpu w/ ht		normal boot
>   2 cpu w/o ht		noht
>   1 cpu w/o ht		nosmp noht
>   1 cpu w/ ht		???
> It looks as if maxcpus=2 counts physical units? I can't try it until Monday.

What on earth are you getting on about?

ia32 is utter crap with respect to power management, virtualization,
and generalized firmware.

If you don't have remote power management, buy it in whatever form
possible.


-- wli
