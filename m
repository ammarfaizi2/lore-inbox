Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129384AbRBLM6f>; Mon, 12 Feb 2001 07:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRBLM6Y>; Mon, 12 Feb 2001 07:58:24 -0500
Received: from limes.hometree.net ([194.231.17.49]:10803 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129384AbRBLM6O>; Mon, 12 Feb 2001 07:58:14 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2001 12:57:35 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <968mjv$l9t$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de>, <20010209080454.A17656@beops-jg2.be.uu.net>
Reply-To: hps@tanstaafl.de
Subject: Re: DNS goofups galore...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jan.gyselinck@be.uu.net (Jan Gyselinck) writes:

>There's not really something wrong with MX's pointing to CNAME's.  It's just that some mailservers could (can?) not handle this.  So if you want to be able to receive mail from all kinds of mailservers, don't use CNAME's for MX's.

No. It breaks a basic assumption set in stone in RFC821. It has
nothing to do with mailer software.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
