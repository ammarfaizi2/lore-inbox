Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130911AbQJ1FgU>; Sat, 28 Oct 2000 01:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbQJ1FgL>; Sat, 28 Oct 2000 01:36:11 -0400
Received: from kootenai.mcn.net ([204.212.170.6]:60677 "EHLO kootenai.mcn.net")
	by vger.kernel.org with ESMTP id <S130896AbQJ1Ff7>;
	Sat, 28 Oct 2000 01:35:59 -0400
Message-ID: <39FA66AC.A8691CAC@mcn.net>
Date: Fri, 27 Oct 2000 23:39:56 -0600
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <20001026173244.B8290@suse.cz> <200010271205.OAA31607@gum04.etpnet.phys.tue.nl> <20001027154122.A923@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> I'm *not* sure. It just looks like a reasonable explanation. It doesn't
> happen on Intel chips and older VIA chips, it only happens on new VIA
> chips, and the code is the same all the time. Also, it happens both with
> 2.2 and 2.4 kernels ...
> 
> --
> Vojtech Pavlik
> SuSE Labs
>

Do you have a method guaranteed to reproduce this?  I have a newer VIA
chipset and haven't (yet) observed this problem.

    Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 2).
    PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (rev 0).
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 34).
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
48).
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 32).


===============
-- TimO
--------------------==============++==============--------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
