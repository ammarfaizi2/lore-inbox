Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWG0PXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWG0PXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWG0PXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:23:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41995 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932495AbWG0PW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:22:59 -0400
Date: Wed, 26 Jul 2006 13:17:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726131709.GB5270@ucw.cz>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C4813E.2030907@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >of the story for me. There's nothing wrong about focusing on newer code,
> >but the old code needs to be cared for, too, to fix remaining issues
> >such as the "can only have N files with the same hash value". 
> >
> Requires a disk format change, in a filesystem without plugins, to fix it.

Well, too bad, if reiser3 is so broken it needs on-disk-format-change,
then I guess doing that change is the right thing to do...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
