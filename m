Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbSKPCbJ>; Fri, 15 Nov 2002 21:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbSKPCbJ>; Fri, 15 Nov 2002 21:31:09 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54192 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267208AbSKPCbI>; Fri, 15 Nov 2002 21:31:08 -0500
Subject: Re: Dual athlon XP 1800 problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ken Witherow <ken@krwtech.com>
Cc: David Crooke <dave@convio.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211151210140.1153-100000@death>
References: <Pine.LNX.4.44.0211151210140.1153-100000@death>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 03:04:29 +0000
Message-Id: <1037415869.21937.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 17:26, Ken Witherow wrote:
> 4) There are a couple bugs with the 760MP chipset and APICs. To see if
> they're affecting you, add "mem=nopentium noapic" to your kernel
> parameters (I can run fine without them).

mem=nopentium isnt related to any AMD760MP/MPX stuff. SOme boxes seem to
need noapic, although a PS/2 mouse may cure that

