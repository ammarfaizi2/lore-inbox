Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSIBMov>; Mon, 2 Sep 2002 08:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIBMov>; Mon, 2 Sep 2002 08:44:51 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20693 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S318286AbSIBMov>; Mon, 2 Sep 2002 08:44:51 -0400
Date: Mon, 2 Sep 2002 14:49:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: silvio@big.net.au
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL]: 2.4.19/drivers/tc/tc.c
In-Reply-To: <20020831041815.A2245@hamsec.aurora.sfo.interquest.net>
Message-ID: <Pine.GSO.3.96.1020902144822.27143F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2002 silvio@big.net.au wrote:

> trivial patch to use const char * instead of char * (this will also make it
> match up the prototype in header)

 Thanks, I'm applying it to the MIPS CVS tree. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

