Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264050AbRFMNFb>; Wed, 13 Jun 2001 09:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264041AbRFMNFV>; Wed, 13 Jun 2001 09:05:21 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:39945 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S263979AbRFMNFL>;
	Wed, 13 Jun 2001 09:05:11 -0400
From: Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.31466.157254.112437@beryllium.pps.jussieu.fr>
Date: Wed, 13 Jun 2001 16:38:34 +0200 (CEST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@suse.cz (Pavel Machek),
        Roberto.Di-Cosmo@pps.jussieu.fr (Roberto Di Cosmo),
        linux-kernel@vger.kernel.org, demolinux@demolinux.org,
        dicosmo@pps.jussieu.fr
Subject: Re: [isocompr PATCH]: announcing stable port to kernel 2.2.18
In-Reply-To: <E159r4y-0001bR-00@the-village.bc.nu>
In-Reply-To: <20010611225944.B959@bug.ucw.cz>
	<E159r4y-0001bR-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 9) "Canyonlands" XEmacs Lucid
Reply-To: Roberto Di Cosmo <roberto@dicosmo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was not aware of the zisofs patch... I will be looking at it
in these days, and try to compare it to the isocompr patch (that
was also brought to our attention by people on the list quite a long
time ago, but we only ended up fixing it recently :-)).

I will keep you posted on the results (this does not prevent others
from doing the comparison, of course, but I promise to post a result
soon)

--Roberto

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> > sometime in the future (I have been looking at 2.4.x code, but the new
    >> page > cache means some changes might be needed: I will try to post a
    >> first version > for 2.4.x soon).
    >> 
    >> I think that 2.5.0 should be your target... It is definitely new feature,
    >> and both 2.4.X and 2.2.X are in feature freeze.

    Alan> How is it different to HPA's zisofs which already exists for 2.4 ?
