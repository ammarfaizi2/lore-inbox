Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSLVQlT>; Sun, 22 Dec 2002 11:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSLVQlT>; Sun, 22 Dec 2002 11:41:19 -0500
Received: from roc-66-66-137-112.rochester.rr.com ([66.66.137.112]:39808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264944AbSLVQlS>; Sun, 22 Dec 2002 11:41:18 -0500
Date: Sun, 22 Dec 2002 11:48:58 -0600 (CST)
From: Ivan Pulleyn <ivan@sixfold.com>
X-X-Sender: <ivan@localhost.localdomain>
To: rmkml <rmkml@wanadoo.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Pbs network card PCnet/FAST 79C971
In-Reply-To: <3E05CD6C.FF9BF954@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0212221147290.2566-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you try using ethtool?

Ivan...

On Sun, 22 Dec 2002, rmkml wrote:

> Hello,
> 
> Im use kernel 2.4.21pre2,
> 
> and I a pbs on my network card ...
> 
> I don't use 100BaseTX / Full-duplex !
> I don't use 100BaseTX / Half-duplex !
> I don't use 10BaseT / Full-duplex !
> 
> I use only mode 10BaseT / Half-duplex ...
> 
> I compile and run "mii" and don't Fix speed ! (100BaseTX/full-duplex)
> 
> My version of pcnet32.c is 1.27b.
> 
> Could any help ?
> 
> My card in use on very old pc box (HP Kayak Pentium II - 400Mhz)
> 
> Regards
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

----------------------------------------------------------------------
Ivan Pulleyn
Sixfold Technologies, LLC
Chicago Technology Park
2201 West Campbell Drive
Chicago, IL 60612

email:    ivan@sixfold.com
voice:    (866) 324-5460 x601
fax:      (312) 421-0388
----------------------------------------------------------------------

