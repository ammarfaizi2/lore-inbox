Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSLIXrZ>; Mon, 9 Dec 2002 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbSLIXrZ>; Mon, 9 Dec 2002 18:47:25 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:190 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266367AbSLIXrY>; Mon, 9 Dec 2002 18:47:24 -0500
Subject: Re: HPT372 RAID controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Spacecake <lkml@spacecake.plus.com>
Cc: Samuel Flory <sflory@rackable.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021209203338.32e8665f.lkml@spacecake.plus.com>
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>
	<3DF4E433.5010207@rackable.com> 
	<20021209203338.32e8665f.lkml@spacecake.plus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 00:31:47 +0000
Message-Id: <1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 20:33, Spacecake wrote:
> In future i'll always try the ac kernel before asking people.

Check the notes on -ac kernels when doing this. I try and note when
stuff is stable or not

> Will this appear in 2.4.21?

I've sent Marcelo the base of the new IDE. Need to chase down some bits
that got lost in the post, then after testing some fixes for portability
that broke sparc64.

