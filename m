Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136156AbRDVO2l>; Sun, 22 Apr 2001 10:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136157AbRDVO2c>; Sun, 22 Apr 2001 10:28:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10000 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136156AbRDVO2Q>; Sun, 22 Apr 2001 10:28:16 -0400
Subject: Re: Request for comment -- a better attribution system
To: matthew@hairy.beasts.org (Matthew Kirkwood)
Date: Sun, 22 Apr 2001 15:29:17 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), esr@thyrsus.com (Eric S. Raymond),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0104221433110.12740-100000@sphinx.mythic-beasts.com> from "Matthew Kirkwood" at Apr 22, 2001 02:42:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rKrY-0005wy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric wants an easy way to find the owner of a CONFIG_ entry.
> True, the consensus seems to be that this isn't a particularly
> useful thing to do, but if it must be done, this seems like an
> eminently sane way to do it.

So we need a system to handle the thousand odd entries, a person to maintain
each item and correct all the errors, processes for handling shared CONFIG_
name space, and procedures for handling registering new entries.

It says one thing 'WOMBAT'

Alan

