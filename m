Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWGXKZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGXKZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 06:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWGXKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 06:25:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:62875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932102AbWGXKZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 06:25:24 -0400
X-Authenticated: #428038
Date: Mon, 24 Jul 2006 12:25:08 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724102508.GA26553@merlin.emma.line.org>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
	Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C4813E.2030907@namesys.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Hans Reiser wrote:

> >and that's the end
> >of the story for me. There's nothing wrong about focusing on newer code,
> >but the old code needs to be cared for, too, to fix remaining issues
> >such as the "can only have N files with the same hash value". 
>
> Requires a disk format change, in a filesystem without plugins, to fix it.

You see, I don't care a iota about "plugins" or other implementation details.

The bottom line is reiserfs 3.6 imposes practial limits that ext3fs
doesn't impose and that's reason enough for an administrator not to
install reiserfs 3.6. Sorry.

-- 
Matthias Andree
