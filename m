Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRE1W46>; Mon, 28 May 2001 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbRE1W4s>; Mon, 28 May 2001 18:56:48 -0400
Received: from tartu.cyber.ee ([193.40.32.242]:21522 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S261502AbRE1W4l>;
	Mon, 28 May 2001 18:56:41 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
In-Reply-To: <20010528231809.A29504@work.bitmover.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.5 (i586))
Message-Id: <E154VwD-0005CB-00@roos.tartu-labor>
Date: Tue, 29 May 2001 00:56:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LM> For what it is worth, in the recent postings I made about this topic, you
LM> suggested that it was bad cabling, I swapped the cabling, same problem.
LM> I swapped the mother board from Abit K7T to ASUS A7V and all cables worked
LM> fine.

Similar info about KT7 - changing cables (both 30 and 80 wire) on Abit KT7 did
not help, still CRC errors (with all disks tried). So it looks like some KT7
boards have problems with IDE interface cabling or smth. like that.

-- 
Meelis Roos (mroos@linux.ee)
