Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbSLEPte>; Thu, 5 Dec 2002 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267341AbSLEPte>; Thu, 5 Dec 2002 10:49:34 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:44685 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S267339AbSLEPtd>; Thu, 5 Dec 2002 10:49:33 -0500
Date: Thu, 5 Dec 2002 07:57:08 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: HTB unsable? (was Re: 2.4.20-ac1 unstable on dual athlon)
In-Reply-To: <Pine.LNX.4.50.0212041511240.31554-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.50.0212050752150.26454-100000@twinlark.arctic.org>
References: <Pine.LNX.4.50.0212041511240.31554-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002, dean gaudet wrote:

> i've got a dual athlon 1.4GHz / 760MP (tyan 2462) which has been solid on
> 2.4.19-pre7-ac4, but which reboot twice in 2 days with 2.4.20-ac1.
>
> i then added "noapic" and the 2.4.20-ac1 kernel lasted all of 5 minutes
> before rebooting.
>
> no messages appeared on serial console.
>
> the kernel configs differed only in that i enabled HTB on the 2.4.20-ac1
> kernel.  i've now patched the 2.4.19-pre7-ac4 kernel with HTB and i'll run
> with this for a while.  below is the config i used for 2.4.20-ac1.

the system rebooted after 8 hours with the 2.4.19-pre7-ac4 + HTB kernel as
well... so perhaps the relevent change is the use of HTB.

or perhaps my hardware has gone bad.

these reboots without anything logged are frustrating.

-dean
