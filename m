Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYJHN>; Thu, 25 Jan 2001 04:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAYJHC>; Thu, 25 Jan 2001 04:07:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7557 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129444AbRAYJGz>;
	Thu, 25 Jan 2001 04:06:55 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14959.60545.51978.532381@pizda.ninka.net>
Date: Thu, 25 Jan 2001 01:06:09 -0800 (PST)
To: Juri Haberland <juri.haberland@innominate.com>
Cc: Jeremy Hansen <jeremy@xxedgexx.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <3A6FD7A0.B45964A8@innominate.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<3A6FD7A0.B45964A8@innominate.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Juri Haberland writes:
 > Forget it. I mailed them and this is the answer:
 > 
 > "As ECN is not a widely used internet standard, and as Cisco does not
 > have a stable OS for their routers that accepts ECN, anyone attempting
 > to access our site through a gateway or from a computer that uses ECN
 > will be unable to do so."

The interesting bit is the "Cisco does not have a stable OS..." part.

I've been told repeatedly by the Cisco folks that a stable supported
patch is available from them for their firewall products which were
rejecting ECN packets.

I'd really like Cisco to reaffirm this and furthermore, and
furthermore get in contact with and correct the hotmail folks
if necessary.

I have in fact noticed that some sites that did have the problem have
installed the fix and are now accessible with ECN enabled.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
