Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVHJVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVHJVbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVHJVbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:31:04 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50871 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030281AbVHJVbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:31:03 -0400
Date: Wed, 10 Aug 2005 17:31:01 -0400
To: Allen Martin <AMartin@nvidia.com>
Cc: Michael Thonke <iogl64nx@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-ID: <20050810213101.GG31019@csclub.uwaterloo.ca>
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 01:53:47PM -0700, Allen Martin wrote:
> Likely the only way nForce4 NCQ support could be added under Linux would
> be with a closed source binary driver, and no one really wants that,
> especially for storage / boot volume.  We decided it wasn't worth the
> headache of a binary driver for this one feature.  Future nForce
> chipsets will have a redesigned SATA controller where we can be more
> open about documenting it.

I never have been able to understand how some hardware that seems so
simple can possibly have anything secret in it.  3D video drivers I can
understand, sound chips I can't (well DSP algorithms maybe, but not
plain doing input.output), network chips should be real simple, and well
ide/sata controllers don't seem like they should be very complex to
program either.

But what do I know...  I find it hard enough to get specs for some
network chips under NDA when you are actually buying the darn chips from
the company.  Some companies appear to fail to realize they are
_hardware_ companies making money selling hardware, not intellectual
property companies.

Well it will be nice to see fully open SATA/IDE controllers in future
nvidia chipsets.  I guess I will put off upgrading my athlon 700 until
those come out. :)

Len Sorensen
