Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWFVLVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWFVLVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWFVLVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:21:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18870 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161071AbWFVLU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:20:59 -0400
Subject: Re: [PATCH] cardbus: revert IO window limit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, alesan@manoweb.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20060622001104.9e42fc54.akpm@osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
	 <20060622001104.9e42fc54.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 12:35:58 +0100
Message-Id: <1150976158.15275.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 00:11 -0700, ysgrifennodd Andrew Morton:
> There is something bad happening in there.  Presumably, this patch will
> break the ThinkPad 600x series machines again though.
> 

Possibly not - remember Linus fixed the "hidden resources" problem with
the PIIX bridge chips.

