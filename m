Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSFDQOa>; Tue, 4 Jun 2002 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSFDQO3>; Tue, 4 Jun 2002 12:14:29 -0400
Received: from pD9E23D09.dip.t-dialin.net ([217.226.61.9]:32422 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314690AbSFDQO2>; Tue, 4 Jun 2002 12:14:28 -0400
Date: Tue, 4 Jun 2002 10:13:55 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Albert Cranford <ac9410@bellsouth.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "linux-i2c@tk.uni-linz.ac.at" <linux-i2c@tk.uni-linz.ac.at>
Subject: Re: [patch] 2.5.20 i2c-elektor fix
In-Reply-To: <1023199475.23874.138.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206041013250.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4 Jun 2002, Alan Cox wrote:
> Surely you just need to include <linux/init.h> ?

This can't be the fix, as <linux/init.h> is already #included.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

