Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbUC3SL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUC3SL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:11:27 -0500
Received: from mx5.Informatik.Uni-Tuebingen.De ([134.2.12.32]:58521 "EHLO
	mx5.informatik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S263797AbUC3SLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:11:21 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Eduard Bloch <edi@gmx.de>,
       David Schwartz <davids@webmaster.com>, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <20040325225423.GT9248@cheney.cx>
	<MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
	<20040326131629.GB26910@zombie.inka.de> <40643BFA.1000302@stesmi.com>
	<20040330113915.GB3084@openzaurus.ucw.cz>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 30 Mar 2004 20:11:14 +0200
In-Reply-To: <20040330113915.GB3084@openzaurus.ucw.cz>
Message-ID: <874qs6nr25.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> If my code contains picture of human, do I have to provide his DNA, too?
> 				Pavel
> 
> (runs away)

If the picture was made with gimp and you keep an xcf of it around for
changing it (because it keeps the layers) but only ship a png (no more
layers) then your violating the GPL.

Prefered form for you would be the xcf file and not the png.

Of cause its hard to show that you do use an xcf as prefered form
without spying at you working on it so you can get away with an png.


With binary firmware is way easier to argue that the prefered form is
some kind of asm, C , forth or whatever source and not the binary.
That someone is prefering a hex editor is very unlikely.

If the driver+firmware is released as GPL (say as binary driver
containing the firmware) then the _firmware_ would be in violation of
the GPL unless source is provided or a note confirming the 3 years on
request thing is there. Either way the source of the firmware has to
be made available.

So please do get firms to release GPLed drivers with firmware included
as GPL bcause then we can sue them for the firmware source. :)

MfG
        Goswin

