Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTA2EfP>; Tue, 28 Jan 2003 23:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTA2EfO>; Tue, 28 Jan 2003 23:35:14 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:13026 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP
	id <S263342AbTA2EfO>; Tue, 28 Jan 2003 23:35:14 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACACF@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Andrew Morton'" <akpm@digeo.com>
Cc: falk.hueffner@student.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5.59] Optimize include/asm-ARCH/page.h:get_order() (
	take 1.0)
Date: Tue, 28 Jan 2003 20:44:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patch is a reorganization and optimization of the get_order()
> > function. 
> 
> Hardly anything uses get_order().  But it seems a reasonable cleanup
> anyway.
> 
> I edited your patch to convert all the eight-spaces to tabs.  Please
> teach your editor to use hard tabs, thanks.

Blame it on me [I prefer spaces to hard tabs]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

