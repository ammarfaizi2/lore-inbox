Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131635AbRBDOF3>; Sun, 4 Feb 2001 09:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRBDOFT>; Sun, 4 Feb 2001 09:05:19 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:50693 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131635AbRBDOFI>; Sun, 4 Feb 2001 09:05:08 -0500
Date: Sun, 4 Feb 2001 13:58:33 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: James Sutherland <jas88@cam.ac.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pavel Machek <pavel@suse.cz>, <andrew.grover@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <Pine.SOL.4.21.0102041151450.18872-100000@orange.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0102041354060.17227-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, James Sutherland wrote:

> For the end-user, the ability to see readings in other units would be
> useful - how many people on this list work in litres/metres/kilometres,
> and how many in gallons/feet/miles? Probably enough in both groups that
> neither could count as universal...

Yeah. We can have this as part of the locale settings, changable by 
echoing the desired locale string to /proc/sys/kernel/lc_all.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
