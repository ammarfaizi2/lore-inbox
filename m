Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTGAQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTGAQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:16:26 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:47999 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262636AbTGAQQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:16:21 -0400
Date: Tue, 1 Jul 2003 11:30:43 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: "David S. Miller" <davem@redhat.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: PCI domain stuff
Message-ID: <20030701113043.A27060@hexapodia.org>
References: <bdr7a6$4eu$1@cesium.transmeta.com> <1057039376.32118.3.camel@rth.ninka.net> <3F0124FC.1010001@zytor.com> <20030630.230329.35692088.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030630.230329.35692088.davem@redhat.com>; from davem@redhat.com on Mon, Jun 30, 2003 at 11:03:29PM -0700
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 11:03:29PM -0700, David S. Miller wrote:
>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date: Mon, 30 Jun 2003 23:06:52 -0700
> 
>    Perhaps a libdirectio would be useful?
>    
> The details are very PCI specific, so what you'd be working
> on initially is a PCI centric library.
> 
> Over time things can be abstracted, but the initial PCI specific
> one would be good enough for xfree86 to link to and make use
> of which is a huge step in the right direction.

There is some interest in the NetBSD project for such an API, as well.
<fair at netbsd.org> filed xsrc/21986 last week.
http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=21986

Perhaps a common implementation could develop.

(OK, I can dream...)

-andy
