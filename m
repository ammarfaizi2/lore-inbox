Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSEMMSm>; Mon, 13 May 2002 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSEMMSl>; Mon, 13 May 2002 08:18:41 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:15750 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313183AbSEMMSl>; Mon, 13 May 2002 08:18:41 -0400
Date: Mon, 13 May 2002 14:18:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@muc.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
In-Reply-To: <20020512205730.A24579@averell>
Message-ID: <Pine.GSO.3.96.1020513141804.26083A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Andi Kleen wrote:

> Yes there is. But it is currently not used for driver configuration,
> only for some internal code. Of course if someone is motived it would
> make sense to mark all EISA drivers with CONFIG_EISA too.

 There are drivers that correctly depend on CONFIG_EISA.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

