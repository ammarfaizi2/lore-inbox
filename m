Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265873AbRF2MbJ>; Fri, 29 Jun 2001 08:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265874AbRF2Ma7>; Fri, 29 Jun 2001 08:30:59 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:57079 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S265873AbRF2Mas>; Fri, 29 Jun 2001 08:30:48 -0400
Date: Fri, 29 Jun 2001 14:31:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Keith Owens <kaos@ocs.com.au>, ankry@green.mif.pg.gda.pl,
        elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error
In-Reply-To: <3B3B9653.A8331780@mandrakesoft.com>
Message-ID: <Pine.GSO.3.96.1010629143015.20975A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Jeff Garzik wrote:

> It is not redundant because in theory CONFIG_EISA could exist without
> CONFIG_ISA.

 Huh?  You can put an ISA card into an EISA slot.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

