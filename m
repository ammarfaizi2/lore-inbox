Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129512AbRBHR6R>; Thu, 8 Feb 2001 12:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRBHR6H>; Thu, 8 Feb 2001 12:58:07 -0500
Received: from limes.hometree.net ([194.231.17.49]:29796 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129512AbRBHR5y>; Thu, 8 Feb 2001 12:57:54 -0500
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Feb 2001 17:43:16 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <95ulrk$aik$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <20010208150632.K15688@mea-ext.zmailer.org>
Reply-To: hps@tanstaafl.de
Subject: Re: DNS goofups galore...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matti.aarnio@zmailer.org (Matti Aarnio) writes:

>NSes and MXes must ALWAYS point to NAMEs with A/AAAA/A6 records for
>them, specifically those names MUST NOT be CNAMEs.   With NSes the

NS: must not
MX: should not

	...stickler for details. ;-)
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
