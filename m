Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQLASRZ>; Fri, 1 Dec 2000 13:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLASRP>; Fri, 1 Dec 2000 13:17:15 -0500
Received: from dweeb.lbl.gov ([128.3.1.28]:5641 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S129736AbQLASRA>;
	Fri, 1 Dec 2000 13:17:00 -0500
Message-ID: <3A27E31E.2428DDB3@lbl.gov>
Date: Fri, 01 Dec 2000 09:42:54 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bj@zuto.de
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bonding...
In-Reply-To: <Pine.LNX.4.30.0011291619440.22577-100000@asdf.capslock.lan> <975575796.3a261af501379@imp.free.fr> <20001130214528.E24351@zuto.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Clasen wrote:
> 
> Ciscos MAC based distribution limits each TCP connection to 100 Mbps.
> 

What's even worse, is Cisco can also *clog* channels with traffic, if
your MAC addresses aren't balanced.  (ie, one line can have all the
traffic, while the other is idle..

-- 
------------------------+--------------------------------------------------
Thomas Davis		| PDSF Project Leader
tadavis@lbl.gov		| 
(510) 486-4524		| "Only a petabyte of data this year?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
