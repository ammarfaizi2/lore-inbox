Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTCFJ3S>; Thu, 6 Mar 2003 04:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTCFJ3S>; Thu, 6 Mar 2003 04:29:18 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:13498 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S267934AbTCFJ3R>;
	Thu, 6 Mar 2003 04:29:17 -0500
Date: Thu, 6 Mar 2003 10:39:45 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <185124756546.20030306103945@tnonline.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Entire LAN goes boo  with 2.5.64
In-Reply-To: <195124534734.20030306103604@tnonline.net>
References: <195124534734.20030306103604@tnonline.net>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Hello,

>    Trying  out  the  2.5.64  kernel  to try to solve some IDE specific
>    problems  with 2.4.x kernels. Now I have another problem. We have a
>    Windows LAN and a Windows XP with WinRoute Pro as gateway.

>    When  booting  the linux-machine with the 2.5.64 kernel the windows
>    machine goes to 100% cpu and the switch (Dlink) goes crazy (loosing
>    link, other machines get 100k/s instead of 10-12MiB/s etc).

>    I  compiled  the  2.5.64  with  as  few  options  as  possible,  no
>    netfilter, or IPSec or similar stuff.

>    What can be the problem?

   Forgot to say I am using a Intel Pro100+ NIC and I have tested with
   both the Becker driver and the Intel driver.



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

