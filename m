Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSKFUwl>; Wed, 6 Nov 2002 15:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSKFUwk>; Wed, 6 Nov 2002 15:52:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18843 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266094AbSKFUwk>; Wed, 6 Nov 2002 15:52:40 -0500
Subject: Re: [Evms-announce] EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <aqbv2d$tvd$1@cesium.transmeta.com>
References: <02110516191004.07074@boiler>
	<20021106001607.GJ27832@marowsky-bree.de>
	<1036590957.9803.24.camel@irongate.swansea.linux.org.uk> 
	<aqbv2d$tvd$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 21:21:58 +0000
Message-Id: <1036617718.9781.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 20:46, H. Peter Anvin wrote:
> I presume that means device mapper is capable of using checksum
> offloading and controller-based block duplication?  If so, that's
> pretty damned nice.  Good work :)

ataraid is just driving dumb ide controllers in the way bios raid does

