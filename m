Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTH0L3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTH0L3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:29:39 -0400
Received: from holomorphy.com ([66.224.33.161]:50614 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263276AbTH0L3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:29:38 -0400
Date: Wed, 27 Aug 2003 04:30:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: warudkar@vsnl.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Message-ID: <20030827113039.GB4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	warudkar@vsnl.net, linux-kernel@vger.kernel.org
References: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 04:38:44PM -0500, warudkar@vsnl.net wrote:
> Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org,
> Rational Rose and Konsole at a time. All of these take extremely long
> time to startup. (approx > 5 minutes). Kswapd hogs the CPU all the time.
> X becomes unusable till all of them startup, although I can telnet
> and run top. Same thing run under 2.4.18 starts up in 3 minutes, X
> stays usable and kswapd never take more than 2% CPU.

Also, can you capture vmstat 1 with this?


-- wli
