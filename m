Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTLOHZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 02:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLOHZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 02:25:05 -0500
Received: from deagol.email.Arizona.EDU ([128.196.133.142]:12700 "EHLO
	smtpgate.email.arizona.edu") by vger.kernel.org with ESMTP
	id S263303AbTLOHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 02:25:02 -0500
Subject: Re: 2.4 vs 2.6
From: Harry McGregor <hmcgregor@espri.arizona.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3FDC9EC8.1000908@mscc.huji.ac.il>
References: <20031201062052.GA2022@frodo>
	 <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
	 <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com> <3FDC0BAC.8020909@mscc.huji.ac.il>
	 <3FDC8957.4000602@yahoo.es>  <3FDC9EC8.1000908@mscc.huji.ac.il>
Content-Type: text/plain
Organization: Tucson Center Support Group - USGS
Message-Id: <1071473021.30831.5.camel@Sony>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 00:23:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-14 at 10:32, Voicu Liviu wrote:

> Because i use lvm2 and I could not find the way to get back to lvm1
> Any clue?

How about using the patches for 2.4 to give you LVM2 support?

http://people.sistina.com/~thornber/

We have it running on one system right now, in fact it is part of the
reason that we manually patched our 2.4.21 to fix the local root exploit
that was fixed in 2.4.23, we just had too many external patches
(FreeSwan, DeviceMapper, XFS, etc) on that system, to do patch and
recompile in a reasonable amount of time.


			Harry

> Liviu


