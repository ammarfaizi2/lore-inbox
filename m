Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbQKFHSM>; Mon, 6 Nov 2000 02:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129405AbQKFHSC>; Mon, 6 Nov 2000 02:18:02 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:32774 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129374AbQKFHRt>; Mon, 6 Nov 2000 02:17:49 -0500
Date: Mon, 6 Nov 2000 07:17:36 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.10.10011060109080.8248-100000@waste.org>
Message-ID: <Pine.LNX.4.21.0011060715431.14068-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Oliver Xymoron wrote:

> Hopefully not. The standard examples (mixer levels, etc) are better
> handled with a userspace tool hooked by modprobe. This even gets
> persistence across reboots if that's what's wanted.

Implement a way for a userspace tool to get the correct mixer levels in
place at the time the sound hardware is reset, so there are no glitches in
the levels, and I'll agree with you.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
