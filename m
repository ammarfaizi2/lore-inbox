Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRAaHAI>; Wed, 31 Jan 2001 02:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRAaG76>; Wed, 31 Jan 2001 01:59:58 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:57874 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130207AbRAaG7k>; Wed, 31 Jan 2001 01:59:40 -0500
Date: Wed, 31 Jan 2001 00:59:37 -0600
To: Miles Lane <miles@megapath.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: mount/umount doesn't track used resources correctly?
Message-ID: <20010131005936.E18746@cadcamlab.org>
In-Reply-To: <3A6CBE53.8050400@megapathdsl.net> <m3elxvnouk.fsf@austin.jhcloos.com> <3A733E33.BEC2174E@cern.ch> <3A73F372.DAA5DFCD@snowbird.megapath.net> <3A73FB0E.DB64D0C0@cern.ch> <m34ryjqefn.fsf@austin.jhcloos.com> <3A750DC4.2ACB4A9F@snowbird.megapath.net> <3A7530A0.8F3D6AEA@cern.ch> <3A77431E.9010605@megapathdsl.net> <3A776890.53BAFBCD@megapath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A776890.53BAFBCD@megapath.net>; from miles@megapath.net on Tue, Jan 30, 2001 at 05:21:20PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Miles Lane]
> I think the problem may be due to usermode tools not handling the new
> "mount multiple devices to a single mount point" feature, but I'm not
> sure.

Yes, quite possibly.  Rumor has it that util-linux has recently
acquired some wisdom in this area.  (I can't confirm or deny.)  Try
upgrading, or just trust /proc/mounts for the real story..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
