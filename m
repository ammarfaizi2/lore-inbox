Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbRFNPQd>; Thu, 14 Jun 2001 11:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbRFNPQX>; Thu, 14 Jun 2001 11:16:23 -0400
Received: from numerator.trivergent.net ([64.89.70.13]:51108 "EHLO
	numerator.trivergent.net") by vger.kernel.org with ESMTP
	id <S263049AbRFNPQO>; Thu, 14 Jun 2001 11:16:14 -0400
Date: Thu, 14 Jun 2001 11:15:44 -0400
From: Brad Johnson <drj@nuvox.net>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
Message-ID: <20010614111544.F25967@nuvox.net>
Mail-Followup-To: Daniel <ddickman@nyc.rr.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>; from ddickman@nyc.rr.com on Wed, Jun 13, 2001 at 08:44:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2001 at 08:44:11PM -0400, Daniel wrote:
> 
> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc
> 
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.

FYI:  Dell still ships computers with on-board sound via ISA bus.

-- 
Words of wisdom from Dr. J.
==============================================================================
Klein bottle for rent -- inquire within. 
