Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFXQCH>; Mon, 24 Jun 2002 12:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSFXQCG>; Mon, 24 Jun 2002 12:02:06 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:8699 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314340AbSFXQCF>; Mon, 24 Jun 2002 12:02:05 -0400
Date: Mon, 24 Jun 2002 18:02:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Frank Davis <fdavis@si.rr.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c
In-Reply-To: <3D173755.8030806@si.rr.com>
Message-ID: <Pine.GSO.3.96.1020624175539.22509O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Frank Davis wrote:

> According to 
> http://www.compaq.com/products/quickspecs/10477_na/10477_na.HTML
> 
> it explictly states 32-bit DMA addressing. It doesn't state anything to 
> suggest 48-bit addressing, which I would think it would if it were possible.

 The page seems to refer to 32-bit data tranfers only, which is what an
average customer is about to understand.  They don't even claim Linux
support anymore, like Digital used to for the A and B versions. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

