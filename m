Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUHJVV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUHJVV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUHJVV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:21:58 -0400
Received: from holomorphy.com ([207.189.100.168]:21996 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267727AbUHJVUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:20:46 -0400
Date: Tue, 10 Aug 2004 14:20:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810212033.GY11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408100937.47451.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 10, 2004 12:21 am, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc4/2.6
>>.8-rc4-mm1/

On Tue, Aug 10, 2004 at 09:37:47AM -0700, Jesse Barnes wrote:
> Needs a build fix for ia64, which is attached.  acpi_noirq wasn't defined for 
> anything but i386, afaict.
> Once I fix the build, it hangs in the same way as 2.6.8-rc3-mm2.  I
> assume wli is still working on fixing that...
> Jesse

Yes. Not quite there yet. I have it down to one printk() and "why does
the printk fix anything?"


-- wli
