Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWIIOXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWIIOXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIIOXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:23:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14011 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932199AbWIIOXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:23:52 -0400
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: "\"J.A." =?ISO-8859-1?Q?Magall=F3n=22?= <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <44FFE7AF.8010808@gmail.com>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060904013443.797ba40b@werewolf.auna.net>
	 <20060903181226.58f9ea80.akpm@osdl.org>	<44FB929B.7080405@gmail.com>
	 <20060905002600.51c5e73b@werewolf.auna.net>  <44FFE7AF.8010808@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 15:46:43 +0100
Message-Id: <1157813203.6877.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-07 am 11:34 +0200, ysgrifennodd Tejun Heo:
> Alan, it seems that 0x848a indicates CFA device iff the ID data is from 
> IDENTIFY DEVICE.  When the command is IDENTIFY PACKET DEVICE, 0x848a 
> seems to indicate a valid ATAPI device.

Apparently so - thats a detail I didn't know about.

Acked-by: Alan Cox <alan@redhat.com>

Alan

