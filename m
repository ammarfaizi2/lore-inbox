Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSGVDgl>; Sun, 21 Jul 2002 23:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSGVDgl>; Sun, 21 Jul 2002 23:36:41 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:64998 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315856AbSGVDgl>; Sun, 21 Jul 2002 23:36:41 -0400
Date: Sun, 21 Jul 2002 21:39:41 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Marcel Holtmann <marcel@holtmann.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
In-Reply-To: <1027251227.2009.16.camel@pegasus>
Message-ID: <Pine.LNX.4.44.0207212139150.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21 Jul 2002, Marcel Holtmann wrote:
> this patch updates the PC Card drivers of the Bluetooth subsystem. It
> modifies the following files: 

Please don't use EXPORT_NO_SYMBOLS where it's avoidable.

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

