Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSGILVa>; Tue, 9 Jul 2002 07:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGILV3>; Tue, 9 Jul 2002 07:21:29 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:13534 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314396AbSGILV0>; Tue, 9 Jul 2002 07:21:26 -0400
Date: Tue, 9 Jul 2002 05:24:04 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <200207091313.07199.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0207090522590.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Roy Sigurd Karlsbakk wrote:
> Should I add IDE9[4567] as well, or does these ones include previous IDE 
> pathes?

It's Linus' current tree plus IDE. So just patch your current tree.

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

