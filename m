Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRIHSKI>; Sat, 8 Sep 2001 14:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271799AbRIHSJ5>; Sat, 8 Sep 2001 14:09:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26929 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271798AbRIHSJt>; Sat, 8 Sep 2001 14:09:49 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: goemon@anime.net (Dan Hollis), acahalan@cs.uml.edu (Albert D. Cahalan),
        david@digitalaudioresources.org (David Hollister),
        jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org,
        rgooch@atnf.csiro.au
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <E15cvHj-0003xk-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Sep 2001 12:01:31 -0600
In-Reply-To: <E15cvHj-0003xk-00@the-village.bc.nu>
Message-ID: <m1elphh890.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > optimizations, you would consider a falsification of the "marginal
> > hardware" theory?
> 
> Not trivially. 
> 
> The current theory is
> 	VIA chipset + Athlon + [unknown factors]
> 
> So seeing it on SiS, AMD or Ali chipsets would be significant

Would it help with the tracking if someone had a board that reliably
crashes before /etc/rc.d/rc finishes running?  And were willing to
help with the investigation?

Eric
