Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUAUNGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAUNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:06:42 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:25789 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265954AbUAUNGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:06:39 -0500
Date: Wed, 21 Jan 2004 13:06:19 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andi Kleen <ak@suse.de>
cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       vojtech@suse.cz
Subject: Re: mouse configuration in 2.6.1
In-Reply-To: <20040121140220.7d96eb47.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401211304090.25485@student.dei.uc.pt>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org>
 <20040121132337.7f8d3c79.ak@suse.de> <Pine.LNX.4.58.0401211228300.25485@student.dei.uc.pt>
 <20040121134204.73e6450f.ak@suse.de> <Pine.LNX.4.58.0401211252440.25485@student.dei.uc.pt>
 <20040121140220.7d96eb47.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 21 Jan 2004, Andi Kleen wrote:

> On Wed, 21 Jan 2004 12:53:12 +0000 (WET)
> "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Wed, 21 Jan 2004, Andi Kleen wrote:
> >
> > > On Wed, 21 Jan 2004 12:31:21 +0000 (WET)
> > > "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> > >
> > > > apparently:
> > > > >
> > > > > psmouse_base.psmouse_proto=bare
> > > >
> > > > Actually it's psmouse.proto=bare
> > >
> > > In 2.6.1 it is definitely psmouse_base.psmouse_proto=bare
> >
> > Do you have it compiled as a module?
>
> No of course not. For a module it would be psmouse_proto=bare
>
> -Andi
>

Oh, I'm sorry, I was talking about 2.6.2-rc1.
Starting in 2.6.1-mm* and now in 2.6.2-rc1 you just have to pass
psmouse.proto=bare .

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

iD8DBQFADnlOmNlq8m+oD34RAgdPAKDeeGMpZOq2ObzIEVHyzUb8ovBarACfdIk0
owGg+aqr2clAfXNod323y9c=
=6PbO
-----END PGP SIGNATURE-----

