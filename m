Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTL2S7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTL2S7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:59:21 -0500
Received: from litaipig.ucr.edu ([138.23.89.48]:973 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id S263895AbTL2S7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:59:12 -0500
Date: Mon, 29 Dec 2003 10:59:08 -0800
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031229185908.GB31215@mail-infomine.ucr.edu>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com> <20031229134150.GB30794@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229134150.GB30794@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Tomas Szepe:
> On Dec-28 2003, Sun, 18:10 -0800
> Samuel Flory <sflory@rackable.com> wrote:
> 
> > PS- Why not at least run software raid 5?  It takes far less cpu than 
> > you'd think, and can save your ass.
> 
> Absolutely.  With eight low-cost IDE disks, you'd be nuts to go raid0
> or linear.
> 

I'll probably go with raid5 and the Promise tx4000 card recommended by Joel.
It looks like I'll have the funding to buy another box and another 1 TiB of
disk space.  Thanks for all the advice!!

> -- 
> Tomas Szepe <szepe@pinerecords.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

Outlook, n.:
        A virus delivery system with added email functionality.
