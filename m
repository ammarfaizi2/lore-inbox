Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGVMDC>; Mon, 22 Jul 2002 08:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGVMDC>; Mon, 22 Jul 2002 08:03:02 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:35098 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S316842AbSGVMDC>; Mon, 22 Jul 2002 08:03:02 -0400
Date: Mon, 22 Jul 2002 06:06:04 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thunder from the hill <thunder@ngforever.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
In-Reply-To: <1027342324.31782.20.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207220605220.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22 Jul 2002, Alan Cox wrote:
> For 2.4 you want to use it whenever possible and a file exports no
> symbols. For 2.5 EXPORT_NO_SYMBOLS is the automatic default behaviour so
> you can lose the line

This was clearly a 2.5 patch, where we currently want to get rid of 
EXPORT_NO_SYMBOLS.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

