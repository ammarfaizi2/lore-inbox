Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSJVLOh>; Tue, 22 Oct 2002 07:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJVLOh>; Tue, 22 Oct 2002 07:14:37 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:58752 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262425AbSJVLOg> convert rfc822-to-8bit; Tue, 22 Oct 2002 07:14:36 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: bert hubert <ahu@ds9a.nl>
Subject: Re: PROBLEM: PCMCIA cardmgr kill hangs kernel
Date: Tue, 22 Oct 2002 13:13:45 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <200210221046.46700.Take.Vos@binary-magic.com> <20021022093410.GA2392@outpost.ds9a.nl>
In-Reply-To: <20021022093410.GA2392@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221313.49423.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

> > kernel:	linux-2.5.43
> > cardmgr:	3.2.1
> > hardware:DELL Inspiron 8100
> > config:	CONFIG_PCMCIA
> > 		CONFIG_CARDUBS
> > 		CONFIG_BLK_DEV_IDECS
> >
> > killing the cardmgr hangs the kernel,
removing the flashcard from the pcmcia slot also hangs the kernel.
So it seams a flashcard issue (I had issues with this card in the early 2.4.x 
kernels, but it would hang the kernel at insertion)

> How hard? Does numlock still work? Can you tell if the CPU is busy
> afterwards (ie, your laptop remains hot).
numlock doesn't work.
CPU gets hot (fans start after a minute).

Thanks
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tTLrMMlizP1UqoURAvXaAJ9MmPl54/qrQKwAdccoe91Q+Of8YwCgp7yP
h4pA8QC95P0+HSaUa3iGuUw=
=6QXb
-----END PGP SIGNATURE-----

