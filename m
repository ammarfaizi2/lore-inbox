Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbQLLSZi>; Tue, 12 Dec 2000 13:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQLLSZ3>; Tue, 12 Dec 2000 13:25:29 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:19442 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130188AbQLLSZL>; Tue, 12 Dec 2000 13:25:11 -0500
Date: Tue, 12 Dec 2000 12:54:42 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Niels Kristian Bech Jensen <nkbj@image.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <F78B9AA62E2@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0012121253470.9083-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i440BX is consistent with mine as is running the drive at UDMA33.

> It happened when I decided to copy old 18GB IDE disk to new 40GB IDE one
> (both UDMA33, one (18GB src) as primary master, one (40GB dst) as
> secondary master; i440BX).

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
