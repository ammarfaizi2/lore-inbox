Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWB0G32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWB0G32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWB0G32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:29:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22291 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751562AbWB0G31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:29:27 -0500
Date: Mon, 27 Feb 2006 07:29:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ross Vandegrift <ross@jose.lug.udel.edu>
Cc: Marc Koschewski <marc@osknowledge.org>, Christian <christiand59@web.de>,
       linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060227062926.GP3674@stusta.de>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214184708.GA29656@lug.udel.edu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:47:08PM -0500, Ross Vandegrift wrote:
> On Tue, Feb 14, 2006 at 05:40:03PM +0100, Marc Koschewski wrote:
> > Is that maybe dependant on _what_ version of Samba is running on the receiving
> > end?
> 
> I've seen it copying to Windows 2k3.  Only uploading large files, and
> it's not every time.  I'd say 50% of the time, my box freezes when
> copying something around 100MiB or larger.
> 
> IIRC, my workstation at the office is running 2.6.15.1 or .4.

Christian, Ross, my freezes are fixed in 2.6.16-rc5.
Can you check whether 2.6.16-rc5 also fixes your freezes?

> Ross Vandegrift

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

