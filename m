Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQKKFdQ>; Sat, 11 Nov 2000 00:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQKKFdG>; Sat, 11 Nov 2000 00:33:06 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:62637 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129675AbQKKFcx>; Sat, 11 Nov 2000 00:32:53 -0500
To: Peter Samuelson <peter@cadcamlab.org>
Cc: George Anzinger <george@mvista.com>, Dan Aloni <karrde@callisto.yi.org>,
        Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.21.0011100051190.31850-100000@callisto.yi.org>
	<3A0C2813.E7CB42D2@mvista.com>
	<20001110215628.A28057@wire.cadcamlab.org>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 10 Nov 2000 21:31:44 -0800
In-Reply-To: <20001110215628.A28057@wire.cadcamlab.org>
Message-ID: <m3u29ff51b.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org> writes:

> > (I prefer EMACS, which likes to unlink.)
> No it doesn't, not always.  Your choice:
>   (setq make-backup-files nil)
>   (setq backup-by-copying t)

i would recommend to use the orig.el[1] from frederic.lepied with Emacs,
it save any files before editing with a particuliar prefix and you can
generate the patch with the gendiff script (included with rpm).

Footnotes: 
[1]  ftp://ftp.chmouel.org/pub/people/chmou/orig.el

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
