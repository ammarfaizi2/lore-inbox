Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVBLS0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVBLS0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVBLS0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:26:17 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:35124 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261177AbVBLS0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:26:15 -0500
Subject: Re: How to disable slow agpgart in kernel config?
From: Arjan van de Ven <arjan@infradead.org>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <420E4812.7000006@web.de>
References: <420E4812.7000006@web.de>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 13:26:13 -0500
Message-Id: <1108232773.4056.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2005 18:26:15.0208 (UTC) FILETIME=[5630FA80:01C51130]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> agpgart: 58,1 frames
> nv_agp: 63,1 frames
> 
> Its a lot in Doom3.


hmm I wonder.. .could you collect lspci -vxxx settings for the AGP
device (lspci -vxxx gives you lots of devices, but only one is relevant)
in both cases, maybe the difference between the two shows something
useful...

