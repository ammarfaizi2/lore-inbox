Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWGKPye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWGKPye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWGKPye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:54:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1005 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751091AbWGKPyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:54:32 -0400
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607110926150.858@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <44AEB3CA.8080606@pobox.com>
	 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>
	 <200607091224.31451.liml@rtr.ca>
	 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
	 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
	 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>
	 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
	 <1152545639.27368.137.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
	 <Pine.LNX.4.64.0607110926150.858@p34.internal.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 17:12:04 +0100
Message-Id: <1152634324.18028.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 09:28 -0400, ysgrifennodd Justin Piszcz:
> Alan/Jeff/Mark,
> 
> Is there anything else I can do to further troubleshoot this problem now 
> that we have the failed opcode(s)?  Again, there is never any corruption 
> on these drives, so it is more of an annoyance than anything else.

Nothing strikes me so far other than the data not making sense. Possibly
it will become clearer later if/when we see other examples.

