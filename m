Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbTCGW3a>; Fri, 7 Mar 2003 17:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261828AbTCGW3a>; Fri, 7 Mar 2003 17:29:30 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:33756 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S261824AbTCGW33>;
	Fri, 7 Mar 2003 17:29:29 -0500
Date: Fri, 7 Mar 2003 23:39:47 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <5918937265.20030307233947@tnonline.net>
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Entire LAN goes boo with 2.5.64
In-Reply-To: <Pine.GSO.4.33.0303071732490.4835-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0303071732490.4835-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 7 Mar 2003, Anders Widman wrote:
>>Yes,  you might be right. WinRoute is running as DCHP for the network,
>>and  the  problems  do  start as soon as Linux tries to lease an IP...
>>hm..

> If you are using DHCP, it is critical that every machine have a correctly
> set clock (see also: xntpd)  Otherwise, the client may see the lease expire
> before it requested it. (what happens in such a case varies with the software
> and version.)

Yes,   but  everything  works very good with 2.4.x kernels (all I have
tested  so far). So the problems comes with 2.5.64.. And, there is not
much network traffic either when this happens...

> --Ricky


   



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

