Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131325AbRBHVqp>; Thu, 8 Feb 2001 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRBHVqf>; Thu, 8 Feb 2001 16:46:35 -0500
Received: from innerfire.net ([208.181.73.33]:58120 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S131325AbRBHVqS>;
	Thu, 8 Feb 2001 16:46:18 -0500
Date: Thu, 8 Feb 2001 13:46:31 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanklfully bind 9 barfs if you even try this sort of thing.

	Gerhard

On Thu, 8 Feb 2001, Henning P. Schmiedehausen wrote:

> matti.aarnio@zmailer.org (Matti Aarnio) writes:
> 
> >NSes and MXes must ALWAYS point to NAMEs with A/AAAA/A6 records for
> >them, specifically those names MUST NOT be CNAMEs.   With NSes the
> 
> NS: must not
> MX: should not
> 
> 	...stickler for details. ;-)
> 		Henning
> 
> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> 
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
