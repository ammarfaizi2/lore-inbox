Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTL2ULL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTL2ULL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:11:11 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:36271 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265379AbTL2UKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:10:48 -0500
Date: Mon, 29 Dec 2003 20:10:00 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: GCS <gcs@lsc.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
In-Reply-To: <20031229163955.GA20207@lsc.hu>
Message-ID: <Pine.LNX.4.58.0312292008430.16514@student.dei.uc.pt>
References: <20031229013223.75c531ed.akpm@osdl.org> <20031229163955.GA20207@lsc.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Dec 2003, GCS wrote:

> On Mon, Dec 29, 2003 at 01:32:23AM -0800, Andrew Morton <akpm@osdl.org> wrote:
> > . A couple of patches here should fix the CDROM-related problems which
> >   some people saw in 2.6.0-mm1.
>  Fixed for me.
>
> > +input-mousedev-remove-jitter.patch
> > +input-mousedev-ps2-emulation-fix.patch
> >
> >  PS/2 mouse fixes.
>  As previously noted, they do work. In result, -mm2 is just fine for me.

Well, as for me, I still can't get the "mouse tap" working with my Asus M3700N
laptop.

> Thanks,
> GCS
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/8IocmNlq8m+oD34RAs1cAKDfW99cAbowOpIlke3irYnn1vdCzQCg5znu
/o4QE9P0ONSwf5VIXRQDWPM=
=CzgG
-----END PGP SIGNATURE-----

