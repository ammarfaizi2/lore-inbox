Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbSKFUju>; Wed, 6 Nov 2002 15:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266083AbSKFUju>; Wed, 6 Nov 2002 15:39:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54542 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266081AbSKFUjt>; Wed, 6 Nov 2002 15:39:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Evms-announce] EVMS announcement
Date: 6 Nov 2002 12:46:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aqbv2d$tvd$1@cesium.transmeta.com>
References: <02110516191004.07074@boiler> <20021106001607.GJ27832@marowsky-bree.de> <1036590957.9803.24.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1036590957.9803.24.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> I'm certainly hoping to kill off ataraid/pdcraid/hptraid by using device
> mapper and md
> 

I presume that means device mapper is capable of using checksum
offloading and controller-based block duplication?  If so, that's
pretty damned nice.  Good work :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
