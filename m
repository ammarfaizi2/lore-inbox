Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274270AbRISXd3>; Wed, 19 Sep 2001 19:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274273AbRISXdY>; Wed, 19 Sep 2001 19:33:24 -0400
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:21204 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S274270AbRISXc3>; Wed, 19 Sep 2001 19:32:29 -0400
Date: Wed, 19 Sep 2001 19:32:47 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Dan Hollis <goemon@anime.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.30.0109191611010.30343-100000@anime.net>
Message-ID: <Pine.A41.4.21L1.0109191929090.16836-100000@login8.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed. Neither my KT133 (Asus A7V bios 1007) nor my KT133A (MSI
K7T-Limited bios 2.8) exhibit the OOPS on boot problem. (For the record,
both have 1 256 pc133 Infineon and 2 128 pc133 Infineons, 1GHz T-bird
[stepping 02].)

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Wed, 19 Sep 2001, Dan Hollis wrote:

> 1) We dont know if all "fixed" BIOS versions do it
> 2) We dont know if all motherboards do it
> 3) We dont have enough data points to determine if this is a "real fix" yet.
> 4) We dont know if they do it under all circumstances
>    (eg do they read SPD and set it in some situations and not others)
>    It may even be CPU rev specific.
> 
> IMHO its *FAR* too premature to be rolling this into production kernels
> based on the scant evidence we have so far.
> 
> -Dan

