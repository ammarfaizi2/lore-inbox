Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWGGTq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWGGTq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWGGTq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:46:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30117 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932289AbWGGTqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:46:25 -0400
Subject: Re: 2.6.17-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, jamagallon@ono.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AE9C67.7000204@garzik.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <20060705234347.47ef2600@werewolf.auna.net>
	 <20060705155602.6e0b4dce.akpm@osdl.org>
	 <20060706015706.37acb9af@werewolf.auna.net>
	 <20060705170228.9e595851.akpm@osdl.org>
	 <20060706163646.735f419f@werewolf.auna.net>
	 <20060706164802.6085d203@werewolf.auna.net>
	 <20060706234425.678cbc2f@werewolf.auna.net>
	 <20060706145752.64ceddd0.akpm@osdl.org>
	 <1152288168.20883.8.camel@localhost.localdomain>
	 <20060707175509.14ea9187@werewolf.auna.net>
	 <1152290643.20883.25.camel@localhost.localdomain>
	 <20060707093432.571af16e.rdunlap@xenotime.net>
	 <1152292196.20883.48.camel@localhost.localdomain>
	 <44AE966F.8090506@garzik.org>
	 <1152294245.20883.52.camel@localhost.localdomain>
	 <44AE9C67.7000204@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 21:03:33 +0100
Message-Id: <1152302613.20883.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 13:39 -0400, ysgrifennodd Jeff Garzik:
> The user doesn't know about soldered bridge chips.  The user knows if he 
> is plugging a PATA or SATA cable into his controller.

In which case the pata_ prefix isnt much use because people soldered
bridge chips onto just about everything in the first SATA rush, before
they all switched to chips that actually did SATA.

Alan

