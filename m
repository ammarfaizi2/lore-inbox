Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135968AbREGBtK>; Sun, 6 May 2001 21:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135974AbREGBtA>; Sun, 6 May 2001 21:49:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11530 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135968AbREGBso>; Sun, 6 May 2001 21:48:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] for iso8859-13
Date: 6 May 2001 18:48:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9d4ut6$9b9$1@cesium.transmeta.com>
In-Reply-To: <200105062104.XAA24831@green.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200105062104.XAA24831@green.mif.pg.gda.pl>
By author:    Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
In newsgroup: linux.dev.kernel
>
> Hi,
>    The following patch removed unused and broken conversion table from
> nls_iso8859-13.c.
> 

Wouldn't it make a heck of a lot more sense if we had a preprocessor
which could produce these kinds of tables from a more sensible input
format (preferrably one which is already in use somewhere.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
