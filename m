Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTK2RLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTK2RLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:11:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64271 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263836AbTK2RLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:11:14 -0500
Date: Sat, 29 Nov 2003 17:11:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, Tim Cambrant <tim@cambrant.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Too soon for stable release?
Message-ID: <20031129171111.A32154@flint.arm.linux.org.uk>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tim Cambrant <tim@cambrant.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031129174916.GA4592@cambrant.com> <20031129170104.GA15333@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031129170104.GA15333@work.bitmover.com>; from lm@bitmover.com on Sat, Nov 29, 2003 at 09:01:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 09:01:04AM -0800, Larry McVoy wrote:
> The news media hasn't picked up on this yet, they seem to think that
> 2.6.0 is something that will be useful.  It won't be, there will be a
> period of months during which things stablize and then you'll see the
> distros pick up the release.  I don't remember where it was exactly
> (2.4.18?) but Red Hat waited quite a while before switching to 2.4
> from 2.2.  This is normal and it works out quite well in practice.

Red Hat did a 2.4.2 release which was 2.4.2 + a lot of stability changes.
IIRC, RH7.x was based on 2.4.7, with updates to 2.4.9, 2.4.18 and finally
2.4.20-based kernels.  However, I also seem to remember each of these had
a fair number of patches applied.

I'm sure Arjan will correct me if I got the above wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
