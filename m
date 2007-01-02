Return-Path: <linux-kernel-owner+w=401wt.eu-S932683AbXABJkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbXABJkv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbXABJkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:40:51 -0500
Received: from ns.firmix.at ([62.141.48.66]:52319 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932683AbXABJku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:40:50 -0500
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Trent Waddington <trent.waddington@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3d57814d0701012230v2e8b31eeqef7e542d73fc08d9@mail.gmail.com>
References: <loom.20061215T220806-362@post.gmane.org>
	 <200612162007.32110.marekw1977@yahoo.com.au>
	 <4587097D.5070501@opensound.com>
	 <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
	 <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu>
	 <20061222115921.GT3073@harddisk-recovery.com>
	 <1167568899.3318.39.camel@gimli.at.home>
	 <3d57814d0612310503r282404afgd9b06ca57f44ab3c@mail.gmail.com>
	 <200701020404.l0244n3b024582@turing-police.cc.vt.edu>
	 <3d57814d0701012230v2e8b31eeqef7e542d73fc08d9@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 02 Jan 2007 10:40:33 +0100
Message-Id: <1167730833.12526.35.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Firmix-Scanned-By: MIMEDefang 2.56 on ns.firmix.at
X-Spam-Score: -2.411 () AWL,BAYES_00,FORGED_RCVD_HELO
X-Firmix-Spam-Status: No, hits=-2.411 required=5
X-Firmix-Spam-Score: -2.411 () AWL,BAYES_00,FORGED_RCVD_HELO
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 16:30 +1000, Trent Waddington wrote:
[...]
> I think you're repeating a myth that has become a common part of
> hacker lore in recent years.  It's caused by how little we know about
> software patents.  The myth is that if you release source code which
> violates someone's patent that is somehow worse than if you release
> binaries that violate someone's patent.  This is clearly, obviously,
> false.  If you're practising the invention without a license in your
> source code then you're practising the invention without a license in
> binaries compiled from that source code.  Period.

While this is true (at last in theory), there is one difference in
practice: It is *much* easier to prove a/the patent violation if you
have (original?) source code than to reverse engineer the assembler dump
of the compiled code and prove the patent violation far enough to get to
a so-called "agreement" on the costs.

> Nvidia are not releasing source code to their drivers for one reason:
> it's not their culture.  They don't see the need.  They don't see the
> benefit.

Which also may well be true.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

