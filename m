Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVDDVi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDDVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVDDVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:30:55 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:28753 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261414AbVDDV1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:27:31 -0400
X-ME-UUID: 20050404212717924.E1A4E1C00122@mwinf0312.wanadoo.fr
Date: Mon, 4 Apr 2005 23:24:05 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404212405.GC3421@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <42519BCB.2030307@pobox.com> <20050404202706.GB3140@pegasos> <4251A7E8.6050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4251A7E8.6050200@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 04:47:36PM -0400, Jeff Garzik wrote:
> Sven Luther wrote:
> >Yep, but in the meantime, let's clearly mark said firmware as
> >not-covered-by-the-GPL. In the acenic case it seems to be even easier, as 
> >the
> >firmware is in a separate acenic_firmware.h file, and it just needs to have
> >the proper licencing statement added, saying that it is not covered by the
> >GPL, and then giving the information under what licence it is being
> >distributed.
> 
> Who has meaningfully contacted Alteon (probably "Neterion" now) about 
> this?  What is the progress of that request?

Nobody yet. I plan to do so as time allows though. But how do you respond
about the firmware blobs being declared as GPL covered in the kernel ? Who put
those firmware blobs there, and form where did they came ? 

> >Jeff, since your name was found in the tg3.c case, and you seem to care 
> >about
> >this too, what is your take on this proposal ?
> >
> >Friendly,
> 
> Bluntly, Debian is being a pain in the ass ;-)

Thanks all the same, in this case, it is just me though, who want a clear
solution to this, and you would too, i guess, especially as it is not much
work to do it in the first place, so why is everyone making a problem of this
? 

> There will always be non-free firmware to deal with, for key hardware.

Sure, but then you don't claim they are covered by the GPL as is currently the
case ? And i thought that the whole SCO affaire teached us to be more careful
about this.

It assuredly can't hurt to add a few lines of comments to tg3.c, and since it
is probably (well, 1/3 chance here) you who added said firmware to the tg3.c
file, i guess you are even well placed to at least exclude it from being
GPLed. Is this not a reasonable request ? Which should get a reasonable
answer, and not claims of being a pain in the ass, and other wild fanatical
accusations ? 

Friendly,

Sven Luther

