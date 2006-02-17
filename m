Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWBQNIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBQNIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWBQNIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:08:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:64224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932325AbWBQNIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:08:39 -0500
X-Authenticated: #428038
Date: Fri, 17 Feb 2006 14:08:36 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060217130836.GB13900@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner> <200602141710.37869.dhazelton@enter.net> <43F4652F.nail20W57J1QB@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner> <20060216202649.28dec1fe.froese@gmx.de> <43F5AA2A.nail2VC71UI32@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5AA2A.nail2VC71UI32@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-17:

> > Well, the kill(getppid(), SIG_INT)s in cdda2wav still cause system
> > reboots when run as root.
> 
> Isn't this unfair?

No. You asked for bugs, you got bugs.
You ship cdda2wav, you take the blame.

> Heiko did not work on cdda2wav since ~ 2.5 years.

Does that alleviate the bug? No.

-- 
Matthias Andree
