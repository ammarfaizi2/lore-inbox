Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTD1XH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTD1XH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:07:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20369
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261373AbTD1XH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:07:27 -0400
Subject: Re: [Patch] DMA mapping API for Alpha
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mzyngier@freesurf.fr
Cc: Jeff Garzik <jgarzik@pobox.com>, rth@twiddle.net,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <wrp1xzmcv44.fsf@hina.wild-wind.fr.eu.org>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
	 <20030428184941.GC18304@gtf.org> <wrp1xzmcv44.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051568455.17369.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 23:20:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-28 at 19:52, Marc Zyngier wrote:
> Oh, and that quad 88110 VME tank is still waiting for me to find some
> spare time... :-)

You may wish to read up on 88xxx trap and exception cleanup first ;)

