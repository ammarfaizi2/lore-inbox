Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRAPWwU>; Tue, 16 Jan 2001 17:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133096AbRAPWwK>; Tue, 16 Jan 2001 17:52:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:44299 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132091AbRAPWv7>; Tue, 16 Jan 2001 17:51:59 -0500
Date: Tue, 16 Jan 2001 16:51:54 -0600
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116165154.A6364@cadcamlab.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95190@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95190@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 16, 2001 at 11:35:36AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Venkatesh Ramamurthy]
> [Venkatesh Ramamurthy] I think there should be a better way to handle
> this , compiling is one of the options, but an end-user should not
> think of compiling. The end user needs to put an another card and
> connect drives and get his system up and running. He should not think
> of compiling the drivers, if it is already part of the kernel /
> initrd to get his system running.

You seem to be full of things that "we" can implement.  So I just have
to wonder: do you by any chance have some prototype code somewhere to
figure out, reliably, which SCSI cards have BIOS extensions enabled,
and the order they hook in?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
