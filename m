Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbSLGNKX>; Sat, 7 Dec 2002 08:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbSLGNKX>; Sat, 7 Dec 2002 08:10:23 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:33297 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267637AbSLGNKV>; Sat, 7 Dec 2002 08:10:21 -0500
Date: Sat, 7 Dec 2002 14:14:24 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207131424.GL32065@louise.pinerecords.com>
References: <997222131F7@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997222131F7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IMO, yes, since those tools provide the summary, and exist almost purely in
> > userspace. I forgot to mention in the orginal email that we could also drop
> > the PCI names database, right? This would save a considerable amount in the
> > kernel image alone..
> 
> If you want, make it user configurable like it was during 2.2.x. But
> I personally prefer descriptive names and system overview I can parse 
> without having mounted /usr to get working lspci.

Actually I'm inclined to insist that lspci belong in /sbin.  Really.  :)

-- 
Tomas Szepe <szepe@pinerecords.com>
