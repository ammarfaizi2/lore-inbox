Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTALOkS>; Sun, 12 Jan 2003 09:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTALOkS>; Sun, 12 Jan 2003 09:40:18 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:405 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S267089AbTALOkR>; Sun, 12 Jan 2003 09:40:17 -0500
Date: Sun, 12 Jan 2003 09:44:44 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Rene Rebe <rene.rebe@gmx.net>
cc: kernel@nn7.de, linux-kernel@vger.kernel.org
Subject: Re: choice of raid5 checksumming algorithm wrong ?
In-Reply-To: <20030111.212056.607951684.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.51.0301120943210.4564@filesrv1.baby-dragons.com>
References: <3E203C00.5060403@inet6.fr> <20030111.203913.846936097.rene.rebe@gmx.net>
 <1042314720.1225.4.camel@sun> <20030111.212056.607951684.rene.rebe@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Rene , All ,  How about just printing the algorithm that is
	chosen & not the others ?  Just an idea .  JimL

On Sat, 11 Jan 2003, Rene Rebe wrote:
> Hi.
> In the case s.o. wants to pull the patch:
> http://www.rocklinux.org/sources/package/base/linux24/82-raid5-niceer-output.patch
> It is only a one-liner. It is not really nice since I print the
> "writing arround L2 cache" text when XOR_SELECT_TEMPLATE is defined -
> this might also be the case for an later AlitVec version for PowerPC
> or so. So we might want a more generic text - or a text in the
> appropriated .h file whetre XOR_SELECT_TEMPLATE is defined ...
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
