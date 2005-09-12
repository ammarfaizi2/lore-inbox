Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVILBkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVILBkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 21:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVILBkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 21:40:25 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:2498 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751125AbVILBkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 21:40:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17188.56404.274267.432393@wombat.chubb.wattle.id.au>
Date: Mon, 12 Sep 2005 11:39:32 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (i)stallion remove
In-Reply-To: <432360A2.7040608@gmail.com>
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
	<43234860.7050206@pobox.com>
	<43234972.3010003@gmail.com>
	<20050910211711.GA13660@suse.de>
	<4323518E.9060407@gmail.com>
	<432352F0.1080502@pobox.com>
	<432360A2.7040608@gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jiri" == Jiri Slaby <jirislaby@gmail.com> writes:

Jiri> (I)stallion remove from the tree, it contains pci_find_device,
Jiri> it is unmaintained and broken for a long time. Noone uses it.

Arrrg!  We're using it!  It works on UP ia64.  If you want to remove
it, please send us a supported 8-port serial card :-)

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
