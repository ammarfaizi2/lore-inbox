Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbRBDANN>; Sat, 3 Feb 2001 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131036AbRBDANE>; Sat, 3 Feb 2001 19:13:04 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:45508 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129758AbRBDAMu>; Sat, 3 Feb 2001 19:12:50 -0500
Message-Id: <l03130321b6a24b3546f2@[192.168.239.105]>
In-Reply-To: <200102032322.f13NMZp438329@saturn.cs.uml.edu>
In-Reply-To: <20010202155341.A149@bug.ucw.cz> from "Pavel Machek" at Feb
 02, 2001 03:53:41 PM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 4 Feb 2001 00:03:25 +0000
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, pavel@suse.cz (Pavel Machek)
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Better battery info/status files
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org (kernel list)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The units seem to vary. I suggest using fundamental SI units.
>That would be meters, kilograms, seconds, and maybe a very
>few others -- my memory fails me on this.

There are lots of SI units, one for each physical dimension that can be
measured.  Some of the ones that might apply here are:

- Volts
- Coulombs
- Watts
- Amperes
- Seconds
- Joules

Some non-SI units that may be acceptable in this context due to common usage:

- Watt-hours (should strictly be joules for this measurement)

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
