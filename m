Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUAPSEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAPSEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:04:51 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:32145 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S263568AbUAPSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:04:50 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16392.10174.106472.474928@jik.kamens.brookline.ma.us>
Date: Fri, 16 Jan 2004 13:04:46 -0500
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
In-Reply-To: <200401161648.i0GGmYlJ002181@81-2-122-30.bradfords.org.uk>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
	<16389.63781.783923.930112@jik.kamens.brookline.ma.us>
	<16391.24288.194579.471295@jik.kamens.brookline.ma.us>
	<200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
	<16392.734.505550.6731@jik.kamens.brookline.ma.us>
	<200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
	<16392.2027.90408.850335@jik.kamens.brookline.ma.us>
	<200401161648.i0GGmYlJ002181@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford writes:
 > Some motherboard BIOSes disable S.M.A.R.T. on drives connected to
 > their on-board controllers on each boot.  Quite possibly some PCI IDE
 > cards do as well.  It's possible, (but probably not likely), that by
 > trying the drive on different controllers a BIOS somewhere has
 > disabled S.M.A.R.T.

The error occurred at least a week after the drive was moved to its
current controller.  In that week both the drive and smartd ran just
fine with no errors.

  jik
