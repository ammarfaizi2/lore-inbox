Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSLIPHj>; Mon, 9 Dec 2002 10:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSLIPHj>; Mon, 9 Dec 2002 10:07:39 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:31164 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265589AbSLIPHi>; Mon, 9 Dec 2002 10:07:38 -0500
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jorg de jong <jorg@dejong.info>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF4A736.9010104@dejong.info>
References: <3DF26772.8040502@dejong.info>
	<3DF26DF4.F1692AFA@digeo.com>	<3DF2759F.1090403@dejong.info> 
	<3DF27AF9.7BA0D1B5@digeo.com>
	<1039310973.27923.0.camel@irongate.swansea.linux.org.uk> 
	<3DF4A736.9010104@dejong.info>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 15:51:51 +0000
Message-Id: <1039449111.10475.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 14:22, jorg de jong wrote:
> As soon as I reset it to 33Mhz the attached drive was detected and
> kernel panics dissapeard. (Redhat kernel 2.4.18..., 2.4.20-ac1. )
> Other I have not tested.

I've added a printk for that case so people will have a guess why it
failed

