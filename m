Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbULEHx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbULEHx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbULEHx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:53:28 -0500
Received: from holomorphy.com ([207.189.100.168]:21961 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261284AbULEHxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:53:23 -0500
Date: Sat, 4 Dec 2004 23:53:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rudolf Usselmann <rudi@asics.ws>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
Message-ID: <20041205075310.GP2714@holomorphy.com>
References: <1102072834.31282.1450.camel@cpu0> <20041203113704.GD2714@holomorphy.com> <1102225183.3779.15.camel@cpu0> <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com> <1102230225.3778.75.camel@cpu0> <Pine.LNX.4.61.0412050025240.6378@montezuma.fsmlabs.com> <1102232685.3777.93.camel@cpu0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102232685.3777.93.camel@cpu0>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 02:44:45PM +0700, Rudolf Usselmann wrote:
> I think I got it !!!
> After fixing my mem eater program (per Adam and Zwane's
> suggestions), I get the attached "end-less" panic ...
> This happens immediately when I start the a.out ...
> So does this make any sense to you guys ? What is wrong with
> my kernel/system ?
> Thanks a lot guys !!!

Much better. Looks like someone broke the VM from that.


-- wli
