Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRBFTTp>; Tue, 6 Feb 2001 14:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRBFTTe>; Tue, 6 Feb 2001 14:19:34 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60688 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129664AbRBFTTX>; Tue, 6 Feb 2001 14:19:23 -0500
Date: Tue, 6 Feb 2001 14:19:15 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: J Brook <jbk@postmark.net>, <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Matrox G450 problems with 2.4.0 and xfree
In-Reply-To: <14BA879D6F34@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0102061413230.6540-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Petr Vandrovec wrote:

>> >>  I don't have Windows installed on my machine, but I find that if I
>> >> cold boot to 2.2 (RH7) first and start up X (4.0.2 with Matrox driver
>                                                             ^^^^^^^^^^^^^
>> >> 1.00.04 compiled in), I am then able to "shutdown -r now" and warm
>     ^^^^^^^^^^^^^^^^^^^
>> >
>> >Yes, they use same secret code... At least I think...
>>
>> Are you refering to Windows or Red Hat Linux?  I can assure you
>> that Red Hat Linux's XFree package doesn't have any secret code
>> in it with 110% certainty.  Nor will it have in the future.
>
>He is using XF4.0.2 with Matrox large-blob driver, not with XFree one.
>I'm 111% sure that this module contains code which is not freely
>available to mortals.

Well then it is NOT the one shipping with Red Hat Linux.

>XFree4.0.2 mga driver does not work with G450 at all. I'm not sure whether
>you (or RedHat) applied G450 patches flying around. But it is still first
>head only, no digital LCD...

I have applied various g450 patches to 4.0.2 from both matrox and
elsewhere, and nobody seems to get it to work correctly.  The
Matrox patches were not completely clean, so I might just pull
them if no public patches appear soon.  It is not our fault for
broken drivers..

If anyone has open source g450 patches against stock 4.0.2 that
get the thing to work at all, _please_ send me unified diffs, and
I will put them into my next build.  I've yet to have my g450 do
anything but turn off my monitor, although a handful of people
claim they get it working to various degrees...  I don't have
g450 specs either so..

No binary modules are in the Red Hat XFree86 RPMS though, nor
will there be.  Only 100% open source.  If the open source
drivers do not work, then the card will not function period, and
will not be supported.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
"Facts do not cease to exist because they are ignored."
                                               - Aldous Huxley

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
