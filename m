Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSLOJsk>; Sun, 15 Dec 2002 04:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSLOJsk>; Sun, 15 Dec 2002 04:48:40 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:6827 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S266307AbSLOJsj>; Sun, 15 Dec 2002 04:48:39 -0500
Date: Sun, 15 Dec 2002 10:56:30 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021215095630.GD16227@charite.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <20021211090829.GD8741@charite.de> <1039622867.17709.31.camel@irongate.swansea.linux.org.uk> <20021211153414.GQ8741@charite.de> <20021211155650.GU8741@charite.de> <1039627740.17709.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039627740.17709.82.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

> The hardware isnt at the normal ide base addresse, yet the chip is
> reporting that it isnt in native mode. As far as I can see this
> configuration isnt allowed.
> 
> We see that the chip isnt in native mode so we defer to the legacy
> scanner. Since the ports are not valid the legacy scanner doesn't find
> them.

Will the fix be for thatbe in 2.4.20-ac3 / 2.4.21-pre2?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
How can you have an email virus? Mail software doesn't execute code,
it just displays messages. 

