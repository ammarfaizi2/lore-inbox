Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQK3XhQ>; Thu, 30 Nov 2000 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbQK3XhH>; Thu, 30 Nov 2000 18:37:07 -0500
Received: from fw.SuSE.com ([202.58.118.35]:13305 "EHLO ss10.oak.suse.com")
	by vger.kernel.org with ESMTP id <S129572AbQK3Xgx>;
	Thu, 30 Nov 2000 18:36:53 -0500
Date: Thu, 30 Nov 2000 15:03:26 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Velizar Bodurski <velizarb@goce.pirincom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0 problems.
In-Reply-To: <Pine.LNX.4.21.0012010105270.22261-100000@goce.pirincom.com>
Message-ID: <Pine.LNX.4.21.0011301503001.8054-100000@ss10.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok I don't have the system in question, but i use others' experience with
> the problem. The system is 2xPentium II Celeron 600 Mhz, 256 MB RAM, Video
> Card Matrox Millenium G400, HDD 15 Gb Maxtor 7200 rpm, 2 Mb Cashe,
> MB Abit BP6.
> Both with kernel version 2.2.17 and 2.4.0-test11 after switching from
> X to the console the system hangs, nothing changes if the console is frame
> buffer or vt. If for X is used XFree 3.3.3.6 then the problem doesn't
> appear.
> Any help is apreciated, I don't really know if the problem is with the
> kernel or with the config, so any directions will be a lot helpfull.
> 
> Thanks in advance.

Do you DRI turned on. IF so turn it off. Your problems will go away then.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
