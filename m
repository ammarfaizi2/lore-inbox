Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSAQD6k>; Wed, 16 Jan 2002 22:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288160AbSAQD6a>; Wed, 16 Jan 2002 22:58:30 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:8328 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288159AbSAQD6K>; Wed, 16 Jan 2002 22:58:10 -0500
Date: Wed, 16 Jan 2002 23:01:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Rik spreading bullshit about VM
Message-ID: <20020116230151.A549@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A couple points to followup on the notion of VM at mem=4m:

2.4.18pre2aa2 can do it:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101123070310781&w=2

2.5.2, 2.4.18-pre4, and 2.4.18-pre3-rmap11b would not allow login 
with boot single mem=4m:

2.4.18-pre3-rmap11b tried with init=/bin/bash and init=/bin/ash,
but that would not produce a prompt either.

Log at:
http://home.earthlink.net/~rwhron/kernel/4m

BTW, I think 4G is more important than 4M.

-- 
Randy Hron

