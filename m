Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUJWRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUJWRXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJWRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:23:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36755 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261250AbUJWRXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:23:39 -0400
Date: Sat, 23 Oct 2004 19:20:37 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Timothy Miller <miller@techsource.com>,
       Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041023172036.GA22940@electric-eye.fr.zoreil.com>
References: <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com> <417955D3.5020206@pobox.com> <41795DEA.8050309@techsource.com> <41796083.9060301@pobox.com> <417965E7.8010408@techsource.com> <41797103.2070005@pobox.com> <1098476845.19435.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098476845.19435.41.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
[...]
> > Another advantage is that a simple "do GL" interface is much more 
> > "future-proof" interface, since it is a very high level interface.
> 
> Not really, we are heading towards real time raytrace and the hardware
> and low level changes dramatically for that (including wanting to do non
> light traces for audio mixing, explosion models etc)

Just curious: how would it prevent to push standardization through OpenGL
extensions if needed ?

--
Ueimor
