Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRDCU0L>; Tue, 3 Apr 2001 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRDCU0D>; Tue, 3 Apr 2001 16:26:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131236AbRDCUZw>;
	Tue, 3 Apr 2001 16:25:52 -0400
Date: Tue, 3 Apr 2001 21:24:49 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: 2.4.2,3 nbd problem, works OK in 2.4.2-ac20,28
Message-ID: <20010403212449.D22569@flint.arm.linux.org.uk>
In-Reply-To: <3AC9BF03.AC0A6661@infratel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC9BF03.AC0A6661@infratel.com>; from vserov@infratel.com on Tue, Apr 03, 2001 at 04:16:04PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 04:16:04PM +0400, Vladimir Serov wrote:
> Unfortunately the details of handling these requests aren't clear for me
> and it's not simple to use Alan Cox patches on ARM cause there not
> supported by Russell King and other people in ARM community (I mean no
> patches again -acxx kernels) and i'm already overloaded by various beta
> and alpha software.

I'll look into the possibility of rooting out the fix in the -ac tree (if
any) tomorrow and dropping it into the next ARM tree.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |        Russell King       linux@arm.linux.org.uk      --- ---
  | | | |            http://www.arm.linux.org.uk/            /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
