Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbRBENlL>; Mon, 5 Feb 2001 08:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRBENlB>; Mon, 5 Feb 2001 08:41:01 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:59320 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129313AbRBENks>; Mon, 5 Feb 2001 08:40:48 -0500
Date: Mon, 5 Feb 2001 14:40:43 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010205144043.H849@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010205013424.A15384@iname.com>; from rbrito@iname.com on Mon, Feb 05, 2001 at 01:34:24AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2001 at 01:34:24AM -0200, Rogerio Brito wrote:
> 	Well, this has nothing to do with the above, but is there any
> 	utility or /proc entry that lets me say to my CD drive that it
> 	should not work at full speed?

/proc/ide/hdX/settings ? The (current,init)_speed settings there?

Give it a try at least ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
