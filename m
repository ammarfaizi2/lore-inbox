Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAGRcc>; Sun, 7 Jan 2001 12:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135510AbRAGRcW>; Sun, 7 Jan 2001 12:32:22 -0500
Received: from mail.zmailer.org ([194.252.70.162]:50446 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129867AbRAGRcQ>;
	Sun, 7 Jan 2001 12:32:16 -0500
Date: Sun, 7 Jan 2001 19:32:13 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Ben Greear <greearb@candelatech.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Message-ID: <20010107193213.D25076@mea-ext.zmailer.org>
In-Reply-To: <20010107173306.C25076@mea-ext.zmailer.org> <E14FIxT-0002ue-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14FIxT-0002ue-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 07, 2001 at 04:46:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 04:46:14PM +0000, Alan Cox wrote:
> But talking between two vlans on the same physical lan you will go in and back
> out via the switch and you wont

  So ?

  If your box is routing in between VLANs, you are using it wrong way, IMO.

  On the other hand, I could very well put clients in some building into
  an set where I have a switch with FE connection to router, and lots of
  10BaseT ports to clients.  Hard-limiting bandwith to said 10 Mbit.

  I use VLAN truncked systems mainly for network administration, for
  DHCP servers.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
