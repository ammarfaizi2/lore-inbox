Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUH2PGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUH2PGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUH2PDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:03:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2177 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268011AbUH2PDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:03:01 -0400
Subject: Re: pwc+pwcx is not illegal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pmarques@grupopie.com, greg@kroah.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
References: <1093634283.431.6370.camel@cube>
	 <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093788018.27901.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 15:00:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-27 at 20:29, Linus Torvalds wrote:
> So stop whining about it. The driver got removed because the author asked 
> for it. 

Please put it back, minus the hooks so the rest of the world can use it.
If not please remove every line of code I've even written because I
don't like the new attitude .. so ner..

Point made ? We can't go around throwing out drivers because the author
had a tantrum. Its also trivial to move the decompressor to user space
where it should be anyway. Similarly the driver is useful without the
binary stuff.

Or do we need a -ac tree again where this time -ac is "added camera" ;)

Alan

