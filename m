Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUIPFvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUIPFvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIPFvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:51:51 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16593 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267405AbUIPFvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:51:50 -0400
Date: Wed, 15 Sep 2004 22:51:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Neil Horman <nhorman@redhat.com>
Cc: Paul Jakma <paul@clubi.ie>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
Message-ID: <20040915225129.B25752@home.com>
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <4148A561.5070401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4148A561.5070401@redhat.com>; from nhorman@redhat.com on Wed, Sep 15, 2004 at 04:26:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:26:09PM -0400, Neil Horman wrote:
> IBM's PowerNP chip was also very simmilar (a powerpc core with lots of 
> hardware assists for DMA and packet inspection in the extended register 
> area).  Don't know if they still sell it, but at one time I had heard 
> they had booted linux on it.

Well, yes, PowerNP support has been in the kernel for years and embedded
Linux distros like Mvista support them.  It's no longer an IBM chip,
though.  AMCC purchased the PPC4xx network processors (PowerNP) from
IBM and later purchased the entire standard SoC PPC4xx product line
from IBM.  That is, except for the PPC4xx STB chips like are found in
the Hauppage MediaMVP, IBM retained those.  AMCC pretty much owns all
the PPC4xx line and PowerNP 405H/L are still available.

-Matt
