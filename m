Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267691AbUGWMur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267691AbUGWMur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 08:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267692AbUGWMuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 08:50:46 -0400
Received: from 34.69-93-140.reverse.theplanet.com ([69.93.140.34]:18090 "EHLO
	andromeda.hostvector.com") by vger.kernel.org with ESMTP
	id S267691AbUGWMuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 08:50:44 -0400
From: "mattia" <mattia@nixlab.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
X-Mailer: NeoMail 1.26
X-IPAddress: 127.0.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1BnzVd-0007W3-6c@andromeda.hostvector.com>
Date: Fri, 23 Jul 2004 08:50:45 -0400
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - andromeda.hostvector.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32089 32090] / [47 12]
X-AntiAbuse: Sender Address Domain - andromeda.hostvector.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What ? :)
I use cryptoloop for all my DVD archives and local partitions!
When dm-crypt will be stable, well tested and compatible with cryptoloop
it could make sense to move to it, otherwise not.
Please do not remove cryptoloop from the stable kernel. 

> You wrote on linux.kernel:
> > dpf-lkml@fountainbay.com wrote:
> >>
> >> Hopefully someone else will follow up, but I hope I'm somewhat
convincing:
> >
> > Not really ;)
> >
> > Your points can be simplified to "I don't use cryptoloop, but
someone else
> > might" and "we shouldn't do this in a stable kernel".
> >
> > Well, I want to hear from "someone else".  If removing cryptoloop will
> > irritate five people, well, sorry.  If it's 5,000 people, well maybe
not.
> 
> I use cryptoloop and I would be really annoyed if it disappeared in
> the stable kernel series. Besides, I read in another mail in this thread 
> that dm-crypt will not work with file-based storage (I'm using 
> cryptoloop on a file), and that it is new and potentially buggy.
> 
> I'm really surprised that people here argue that dm-crypt doesn't get 
> enough testing so cryptoloop has to go to force people to test dm-crypt 
> with their valuable data. This is all upside-down. First dm-crypt has to 
> be stable, safe and feature-complete, then people can convert their data 
> to dm-crypt and only then can cryptoloop be deleted.
> 
> Walter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 

