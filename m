Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRBDMBs>; Sun, 4 Feb 2001 07:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRBDMBi>; Sun, 4 Feb 2001 07:01:38 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:58526 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129810AbRBDMBW>; Sun, 4 Feb 2001 07:01:22 -0500
Date: Sun, 4 Feb 2001 11:53:40 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Pavel Machek <pavel@suse.cz>,
        andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <200102032331.f13NVQ726716@flint.arm.linux.org.uk>
Message-ID: <Pine.SOL.4.21.0102041151450.18872-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Russell King wrote:

> Albert D. Cahalan writes:
> > The units seem to vary. I suggest using fundamental SI units.
> > That would be meters, kilograms, seconds, and maybe a very
> > few others -- my memory fails me on this.
> 
> iirc, SI comes from France, and therefore it should be "metres"

Yes. Quite why a distance matters to the battery is another question,
though...

For the end-user, the ability to see readings in other units would be
useful - how many people on this list work in litres/metres/kilometres,
and how many in gallons/feet/miles? Probably enough in both groups that
neither could count as universal...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
