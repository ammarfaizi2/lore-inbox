Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUBPP2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUBPP2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:28:03 -0500
Received: from mail.shareable.org ([81.29.64.88]:12164 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265655AbUBPP2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:28:01 -0500
Date: Mon, 16 Feb 2004 15:27:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Eduard Bloch <edi@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216152757.GD16658@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216140338.GA2927@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:
> Yup, I know that problem. At least to display them correctly, you can
> either run unicode_start (to enable console's own conversion) which
> sucks when they are chars from completely different language groups, eg.
> latin and cyrillic. I used dynafont for a while which worked well for
> displaying characters.

Sorry, unicode_start doesn't work on most terminals (e.g. the VT100
downstairs or the Putty in the internet cafe), and it's also very
antisocial to do when I log in from someone else's Linux console.

-- Jamie
