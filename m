Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbRAXJdD>; Wed, 24 Jan 2001 04:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRAXJcx>; Wed, 24 Jan 2001 04:32:53 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:1801 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130755AbRAXJcp>;
	Wed, 24 Jan 2001 04:32:45 -0500
Date: Wed, 24 Jan 2001 10:32:33 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101240932.KAA13200@db0bm.ampr.org>
To: vandrove@vc.cvut.cz
Subject: Re: display problem with matroxfb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Petr,

> Grr. Did not pass through due to DUL blacklist...
What is DUL blacklist ?
If the problem is with my e-mail address (it is an hamradio address), you can
use <jean-luc.coulon@wanadoo.fr> instead.

> Can you try 'video=matrox:init' ? And 'video=matrox:nopan'?

Bingo ! 'init' does not work but 'nopam' give me a normal display without the
fbset gimnick.

Thank you for the help.

Next step will be to test dual head. I've already installed an AGP ATI (S3
chipset) together with the PCI matrox Mystique and it seems to work. If I
succeed, I will attach a normal VGA display on the ATI board and a 19" IBM (not
multisync) on the Matrox. The ATI card is a cheap one with only 4Mb RAM. I've
upgraded my Matrox Mystique to 8Mb, so I hope it will work.
Now, I will have a look on how to use XF68_FBDev (if needed).

--
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
