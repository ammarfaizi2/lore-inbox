Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbQKAXoy>; Wed, 1 Nov 2000 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130527AbQKAXoq>; Wed, 1 Nov 2000 18:44:46 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:27034 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S130006AbQKAXoj> convert rfc822-to-8bit; Wed, 1 Nov 2000 18:44:39 -0500
Date: Wed, 1 Nov 2000 23:45:01 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <200011012247.OAA19546@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10011012328400.370-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2000, David S. Miller wrote:

>    Date: 	Wed, 1 Nov 2000 23:57:34 +0100
>    From: Kurt Garloff <garloff@suse.de>
> 
>    kgcc is a redhat'ism.
> 
> Debian has it too.

If it has such (I don't know), then their own kgcc does not seem to have
confused users.

This let me propose to fix the above comments as follows:

        The kgcc mess is a redhat-7'ism.

May-be, the kgcc thing is not a bad idea (I would obviously prefer to use
a single gcc release on a given system), but, as it is presented in redhat
7.0, it looks like a show-stopper given all that have been reported about.
A red dune's cap redhat should deserve for this one, in my opinion. ;-)

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
