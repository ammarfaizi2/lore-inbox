Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUCBIA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUCBIA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 03:00:27 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15301 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261501AbUCBIAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 03:00:21 -0500
Date: Tue, 2 Mar 2004 03:00:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Steve Lee <steve@tuxsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1 problems with e100 & 3c59x
In-Reply-To: <005b01c3ffd3$54955140$8119fea9@pluto>
Message-ID: <Pine.LNX.4.58.0403020258110.29087@montezuma.fsmlabs.com>
References: <005b01c3ffd3$54955140$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Steve Lee wrote:

> I've searched the archives as well as googled around without any luck
> regarding my situation.  BTW, please CC me as I'm no longer subscribed
> (furthering my education has prevented me from keeping up with the
> list).
>
> Can anyone please give me some clue as to what might be wrong?  My
> network is working fine with the drivers compiled in 2.6.3 (but not as
> modules).  I can't get 2.6.4-rc1 to work at all with my network cards.

One thing to make sure is that you're using /etc/modprobe.conf and don't
load the modules manually.

	Zwane
