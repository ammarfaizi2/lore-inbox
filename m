Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVCXQ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVCXQ1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCXQ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:27:47 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:61139 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262578AbVCXQ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:27:45 -0500
Date: Thu, 24 Mar 2005 11:27:06 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Asfand Yar Qazi <ay1204@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050324162706.GJ17865@csclub.uwaterloo.ca>
References: <4242865D.90800@qazi.f2s.com> <20050324093032.GA14022@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324093032.GA14022@havoc.gtf.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 04:30:32AM -0500, Jeff Garzik wrote:
> Well, let's cut through the B.S. ;-)
> 
> * Even when the SATA core is updated to support NCQ, nForce will not
> support it under Linux.  No hardware info.

Hmm, either that or someone will figure it out anyhow, like they did
with forcedeth.  Would be nice if nvidia would realize just how dumb not
releasing programing specs is.  How can that be considered a secret.
Maybe they just have a company wide policy of "release nothing" rather
than "don't release the clever 3D acceleration in our drivers that ATI
can't have".  Some comapnies just don't seem to realize they are in the
business of _selling_ hardware, not hardware interface specifications.

> * "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
> it in any case.
> 
> * overclocking -- overclockers are always playing with fire.  any
> overclocked hardware is suspect and unsupportable.
> 
> * via comes with gigabit lan these days.  My own VIA-based Athlon64
> system comes with r8169 gigabit.

I think the r8139 has ruined realtek for me forever.  I like the Marvell
Yukon chip Asus includes on many boards (although some people have
reported problems with some Asus boards using them with Linux).

Len Sorensen
