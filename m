Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTL1WOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTL1WOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 17:14:46 -0500
Received: from mail-infomine.ucr.edu ([138.23.89.48]:47826 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id S262111AbTL1WOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 17:14:45 -0500
Date: Sun, 28 Dec 2003 14:14:43 -0800
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>, linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031228221443.GC21459@mail-infomine.ucr.edu>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu> <20031228213535.GA21459@mail-infomine.ucr.edu> <1072647938.10298.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072647938.10298.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Arjan van de Ven:
> On Sun, 2003-12-28 at 22:35, Johannes Ruscheinski wrote:
> 
> > Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
> > hardware raid capability of the Promise tx4000 and if we'd use software
> > raid instead, what would be the CPU overhead?
> 
> be careful, almost all ata raid controllers out there are *software
> raid* hidden in a binary only driver. Also generally the on-disk format

Binary-only drivers are quite unacceptable to me!

> of these is quite unfortionate resulting in slower access than linux
> software raid can do...

Thanks for the advice!

-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

Outlook, n.:
        A virus delivery system with added email functionality.
