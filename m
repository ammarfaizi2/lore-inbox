Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUIHQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUIHQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUIHQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:31:25 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:23752 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268844AbUIHQa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:30:58 -0400
Subject: Re: 2.6.9-rc1
From: Benoit Dejean <benoit.dejean@placenet.org>
Reply-To: TazForEver@dlfp.org
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908160527.GS2258@suse.de>
References: <1094655493.18454.23.camel@athlon>
	 <20040908153439.GM2258@suse.de>
	 <20040908155742.GA19335@elektroni.ee.tut.fi>
	 <20040908160527.GS2258@suse.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Sep 2004 18:30:55 +0200
Message-Id: <1094661056.1922.0.camel@athlon>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 08 septembre 2004 à 18:05 +0200, Jens Axboe a écrit :
> > bio_uncopy_user-mem-leak-fix.patch and bio_uncopy_user-mem-leak.patch were
> > not included in 2.6.9-rc1.
> 
> oh right you are, I forget that the -rc1 is already so old. so the
> problem is expected, upgrade to latest -rc1-bkX and you'll be fine.

ok, thank you.

-- 
Benoît Dejean
JID: TazForEver@jabber.org
gDesklets http://gdesklets.gnomedesktop.org
LibGTop http://directory.fsf.org/libgtop.html
http://www.paulla.asso.fr

