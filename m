Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbUJ2BTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUJ2BTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbUJ2BSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:18:25 -0400
Received: from holomorphy.com ([207.189.100.168]:52621 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263200AbUJ2Aeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:34:44 -0400
Date: Thu, 28 Oct 2004 17:34:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@redhat.com, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: PATCH to fix initialisation issue for GC3 (linux-2.5.64 +).
Message-ID: <20041029003417.GW12934@holomorphy.com>
References: <Pine.LNX.4.10.10410290107100.1071-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10410290107100.1071-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:27:51AM +0100, Mark Fortescue wrote:
> This patch fixes an error in the blanking code for the GCThree SBUS
> video card. Now I get a logo and black screen, not just a blank (no
> video) screen. It is a trivual fix that has taken too long to identify as
> it is such a small typing error during the rewriting of the code for
> the new frame buffer system introduced in the 2.5 series kernels.
> Given that it still exists in the 2.6.8.1 kernel, I assume that not many
> people have tried using the latest kernel on systems with a CGThree.

Yes, all my systems are headless unfortunately.


-- wli
