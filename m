Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269699AbUJAFYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269699AbUJAFYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbUJAFYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:24:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:43793 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269699AbUJAFYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:24:51 -0400
Date: Fri, 1 Oct 2004 07:21:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: arjanv@redhat.com, "Miller, Mike (OS Dev)" <mike.miller@hp.com>,
       Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
Subject: Re: patch so cciss stats are collected in /proc/stat
Message-ID: <20041001052146.GD721@alpha.home.local>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net> <1096476186.2786.45.camel@laptop.fenrus.com> <415AE9CF.40008@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415AE9CF.40008@xss.co.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 06:58:55PM +0200, Andreas Haumer wrote:
> The majority of _our_ customers are using 2.4.x kernels
> (x beeing in the range from 19 to 28pre3) and it looks like
> it will stay that for quite a while...

I second this. The only one of our customers who tried 2.6 went back to
2.4 because of poor network performance, scheduling problems and stability
issues.

> PS: I know this is somewhat off topic, but I just want to raise
> my voice if I get the impression kernel developers forget about
> the "real world outside". I will shut up in a moment! Thank you!

Very true. You just have to read any 2.6 changelog to understand that
it *is* a development kernel ! The difference between 2.5 and 2.6 is
that the test platform now is larger and includes production systems.

Willy

