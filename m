Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCQQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCQQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:53:26 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:33430 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S261380AbUCQQxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:53:18 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: vmware on linux 2.6.4
Date: Wed, 17 Mar 2004 16:43:54 +0000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <F33BEF5248@vcnet.vc.cvut.cz>
In-Reply-To: <F33BEF5248@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403171643.54923.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On 17 Mar 04 at 16:19, Mark Watts wrote:
> > > > Suggestions welcome.
> > >
> > > what vmware version do you use? Please make sure you've updated to
> > > latest any-any update from (1.)
> >
> > What does this update actually do?
>
> I would suggest reading changelog from any-any update. Entries after
> update50 (and second half of update50) are ones which are NOT in modules
> which come with WS4.5.1. If modules coming with WS4.5.1 work for you,
> fine. If they do not work, you know where to find update...

Ah great - we're using WS4.5.1 and I see that the any-any updates from -50 
probably don't apply to Mandrake 10.0

>
> Update does not handle GSX 3.0 yet, so if you are using GSX 3.0, you
> should stick with officially supported host kernels (if you bought
> GSX, you probably want to have support, and so you should use only
> supported hosts anyway).

We're actually toying with getting a copy of GSX - does it support 2.6 at all?

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAWIBKBn4EFUVUIO0RAukKAKCE1LW6WHqb2iKOVB8loU+d3GblCACgvoXZ
0VgSZZnbZLo3fA4y956QIcY=
=V4Vq
-----END PGP SIGNATURE-----

