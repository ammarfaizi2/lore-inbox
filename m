Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSGHRTw>; Mon, 8 Jul 2002 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSGHRTw>; Mon, 8 Jul 2002 13:19:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24069
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317018AbSGHRTu>; Mon, 8 Jul 2002 13:19:50 -0400
Date: Mon, 8 Jul 2002 10:20:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries.Brouwer@cwi.nl
cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: IDE, util-linux
In-Reply-To: <UTC200207081650.g68GoJJ02428.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.10.10207081018350.4209-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries,

Bart gets it, where others in the past were clueless.  He will fix the
gross bug bomb designs, and he will address the HBA issues.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Mon, 8 Jul 2002 Andries.Brouwer@cwi.nl wrote:

> >> recklessly booted 2.5.25. It survived for several hours,
> >> then deadlocked. Two filesystems turned out to be corrupted.
> >> Wouldn't mind if the rock solid 2.4 handling of HPT366
> >> was carefully copied to 2.5
> 
> > Don't run vanilla 2.5.25, it has only IDE-93...
> 
> Yes. Funny isn't it? Every few weeks the past two or three
> months I reported on the status of 2.5 on my hardware.
> Always the answer is: yes, we know, the current version is
> broken, wait for version N+1.
> 
> I hope you noticed the HPT366 part of my letter, and not
> only the deadlock part.
> 
> Andries
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

