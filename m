Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNUO7>; Thu, 14 Dec 2000 15:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbQLNUOt>; Thu, 14 Dec 2000 15:14:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129773AbQLNUOd>;
	Thu, 14 Dec 2000 15:14:33 -0500
Date: Thu, 14 Dec 2000 11:27:55 -0800
Message-Id: <200012141927.LAA05847@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ionut@moisil.cs.columbia.edu
CC: mhaque@haque.net, linux-kernel@vger.kernel.org
In-Reply-To: <200012141838.eBEIc1v08746@moisil.dev.hydraweb.com> (message from
	Ion Badulescu on Thu, 14 Dec 2000 10:38:01 -0800)
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <200012141838.eBEIc1v08746@moisil.dev.hydraweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 14 Dec 2000 10:38:01 -0800
   From: Ion Badulescu <ionut@moisil.cs.columbia.edu>

   I won't venture a fix, as I don't know the networking code well
   enough. So far, no networking maintainer has had anything to say
   about this bug on the list...

Because this is the first most of us have heard of the issue, much
less seen any ksymoops processed OOPS logs of the bug so we can even
start thinking about what might be wrong.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
