Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSGaVfB>; Wed, 31 Jul 2002 17:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317960AbSGaVfB>; Wed, 31 Jul 2002 17:35:01 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:5248 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317814AbSGaVfB>; Wed, 31 Jul 2002 17:35:01 -0400
Date: Wed, 31 Jul 2002 23:45:52 +0200
Organization: Pleyades
To: aaronl@vitelus.com, linux-kernel@vger.kernel.org
Subject: Re: ATAPI CD-R lags system to hell burning in DAO mode; but not in 
 TAO
Message-ID: <3D485A90.mailK91194I6@viadomus.com>
References: <20020731203008.GA27702@vitelus.com>
In-Reply-To: <20020731203008.GA27702@vitelus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Aaron :)

>My friend has a Plextor PX-W2410A burner with similar specifications,
>and it has the same symptoms as I do. I believe he has a VIA IDE
>chipset.

    I have a Plextor 12/10/32 (just a bit newer) with a VIA chipset
on the mobo, and the only thing that is affected when burning DAO is
X Window. I've made a little test: compiling three kernels 2.4.18 and
playing the burned files while burning at 12x in DAO runs smoooooth.
In fact, I haven't noticed the test finish since the performance was
almost the same. But X freezes.

    IMHO it's a problem of X, not kernel :?? FYI I have 512M of RAM
and a Duron 850 (over 1700-1800 bogomips).

    Raúl
