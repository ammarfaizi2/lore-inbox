Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTK2FjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 00:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTK2FjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 00:39:21 -0500
Received: from www.willden.org ([63.226.98.113]:31932 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S263653AbTK2FjO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 00:39:14 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: Misha Nasledov <misha@nasledov.com>
Subject: Re: APM Suspend Problem
Date: Fri, 28 Nov 2003 22:38:18 -0700
User-Agent: KMail/1.5.93
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031127062057.GA31974@nasledov.com> <20031129021712.GA13798@nasledov.com> <20031129022005.GE8039@holomorphy.com>
In-Reply-To: <20031129022005.GE8039@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311282238.21420.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 28 November 2003 07:20 pm, William Lee Irwin III wrote:
> There is an oddity I forgot to report: it doesn't suspend when I close
> the lid if I still have the power plugged in. Also, I tried the suspend
> button, and it works perfectly fine here for both suspend and resume on
> a standard LTC issue Stinkpad T21, again with the power cord proviso.

Do you also have a PCMCIA card in the slot?

I've always found that my Thinkpads (about three different models, 
currently a T21) will not suspend with power connected and a PCMCIA card 
in.  If I remove either power or my PC cards, then closing the lids will 
trigger a suspend.

I stumbled across something a while back that indicated this was a Thinkpad 
BIOS bug, but I have no idea if that is correct.

Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yDDKp1Ep1JptinARAgu1AJ40eoI5vtCoerCKTmiiPZ51p4wnJACfVnG4
n14zSi/w1CxearTEnUhddDk=
=LKXp
-----END PGP SIGNATURE-----
