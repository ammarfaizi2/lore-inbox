Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJAPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJAPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJAPiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:38:24 -0400
Received: from mail-8-bnl.tiscali.it ([213.205.33.228]:425 "EHLO
	mail-8-bnl.tiscali.it") by vger.kernel.org with ESMTP
	id S262418AbUJAPiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:38:22 -0400
Date: Fri, 1 Oct 2004 17:13:02 +0200
Message-ID: <4152E81E00002199@mail-8-bnl.mail.tiscali.sys>
In-Reply-To: <20040930174155.GT16153@parcelfarce.linux.theplanet.co.uk>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: =?ISO-8859-15?Q?RE=3A=20=5Bparisc=2Dlinux=5D=20Re=3A=20=5BPATCH=5D=20Sort=20generic=20PCI=20fixups=20after=20specific=09ones?=
To: "Matthew Wilcox" <matthew@wil.cx>,
       "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@zip.com.au>,
       "Matthew Wilcox" <matthew@wil.cx>, "Greg KH" <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> 
> Allow prioritising PCI fixups.  "How it works" is covered in the comment
> in pci.h.  The patch to superio.c may well only apply with fuzz to the
> current Linux tree; I include it only to show an example.
> 
Works fine to build a bootable kernel 32bit 2.6.9-rc3-pa0 for a b2k :)

Thanks a lot,
    Joel

---------------------------------------------------------------------------
Tiscali ADSL GO, 29,50 Euro/mois pendant toute une année, profitez-en...
http://reg.tiscali.be/adsl/welcome.asp?lg=FR




