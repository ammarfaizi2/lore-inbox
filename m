Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTKDMsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTKDMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 07:48:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63623
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262057AbTKDMsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 07:48:39 -0500
Date: Tue, 4 Nov 2003 13:48:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Clark <jamie@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 scsi oops
Message-ID: <20031104124803.GC3720@x30.random>
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA79308.3070300@metaparadigm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 07:52:40PM +0800, Jamie Clark wrote:
> the oops and before this fix).  The maximum latency seemed steady over
> the whole test without any of the longish pauses that showed up under
> 2.4.19. Quite a difference.

this is the effect of the elevator-lowlatency also merged in mainline
recently. Good to hear, thanks.
