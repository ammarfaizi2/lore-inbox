Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285114AbRLUURn>; Fri, 21 Dec 2001 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLUURe>; Fri, 21 Dec 2001 15:17:34 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:27653 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S285114AbRLUURS>; Fri, 21 Dec 2001 15:17:18 -0500
Message-ID: <3C23988D.47A96760@ixiacom.com>
Date: Fri, 21 Dec 2001 12:16:13 -0800
From: Dan Kegel <dkegel@ixiacom.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: Linux 2.4.17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote:

> Well, 
> 
> Here it is... 
> 
> 
> final:
> 
> - Fix more loopback deadlocks                   (Andrea Arcangeli)
> - Make Alpha with Nautilus chipset and
>   Irongate chipset configuration compile
>   correctly                                     (Michal Jaegermann)
> 
> rc2: 
> 
> - Fix potential oops with via-rhine             (Andrew Morton)
> - sysvfs: mark inodes as bad in case of read 
> ...

Um, what happened to the idea of 'no changes between the last
release candidate and final'?

I'm disappointed; I thought we were entering a new era of
release discipline in the stable kernel. 

- Dan
