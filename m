Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSGODmN>; Sun, 14 Jul 2002 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSGODmM>; Sun, 14 Jul 2002 23:42:12 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:41425 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317306AbSGODmL>; Sun, 14 Jul 2002 23:42:11 -0400
Date: Sun, 14 Jul 2002 23:44:57 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714234457.A21658@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	Thunder from the hill <thunder@ngforever.de>,
	linux-kernel@vger.kernel.org
References: <20020714233440.A21612@shookay.newview.com> <Pine.LNX.4.44.0207142138040.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207142138040.3452-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Sun, Jul 14, 2002 at 09:38:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 09:38:16PM -0600, Thunder from the hill wrote:
> Hi,

  Hi,
 
> Please time the erase!

Had the same idea: :-)
mchouque - /tmp/joerg %/usr/bin/time rm -rf rock
0.18user 6.10system 0:09.27elapsed 67%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (139major+20minor)pagefaults 0swaps
/usr/bin/time rm -rf rock  0.18s user 6.10s system 67% cpu 9.277 total

Not too bad if you think it took 1 hour something to create the
directory... 
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
