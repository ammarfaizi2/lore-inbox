Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUAPP1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUAPP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:27:29 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:37264 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265229AbUAPP12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:27:28 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16392.734.505550.6731@jik.kamens.brookline.ma.us>
Date: Fri, 16 Jan 2004 10:27:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
In-Reply-To: <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
	<16389.63781.783923.930112@jik.kamens.brookline.ma.us>
	<16391.24288.194579.471295@jik.kamens.brookline.ma.us>
	<200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford writes:
 > Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
 > > ... hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
 > > ... hde: drive_cmd: error=0x04 { DriveStatusError }
 > 
 > The drive doesn't seem to understand the command it was sent.

I'm not sure what this means, but assuming that it's going to happen
again at some point, what do I need to do to my kernel/configuration
now to be able to capture additional debugging information the next
time it happens?

Thanks,

  jik
