Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSCMAC5>; Tue, 12 Mar 2002 19:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSCMACy>; Tue, 12 Mar 2002 19:02:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40722 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291169AbSCMACg>; Tue, 12 Mar 2002 19:02:36 -0500
Date: Wed, 13 Mar 2002 00:02:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Message-ID: <20020313000229.D13558@flint.arm.linux.org.uk>
In-Reply-To: <200203122355.PAA08344@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203122355.PAA08344@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Mar 12, 2002 at 03:55:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 03:55:36PM -0800, Adam J. Richter wrote:
> 	Are you talking about an event that occurred in the 2.4
> tree or the 2.5 tree?  Are you saying that the newer driver in
> 2.4 was reverted back to the older driver (i.e., the one that
> is in 2.5), or are you saying that someone made some attempt
> at porting the 2.5 tree's NCR53C80 driver the new DMA mapping
> interface and then backed them out?

Someone had a go at "making 2.5 compile" without taking Alan's 2.4
changes. It went into Linus tree.  It got subsequently reverted
because of the reasons I outlined in my previous mail.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

