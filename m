Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268211AbRGWMOb>; Mon, 23 Jul 2001 08:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268212AbRGWMOV>; Mon, 23 Jul 2001 08:14:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64389 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268211AbRGWMOP>;
	Mon, 23 Jul 2001 08:14:15 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.5400.694901.897449@pizda.ninka.net>
Date: Mon, 23 Jul 2001 05:14:16 -0700 (PDT)
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alignment of dev_addr[] field in the struct net_device
In-Reply-To: <20010723160331.A583@jurassic.park.msu.ru>
In-Reply-To: <20010723160331.A583@jurassic.park.msu.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Ivan Kokshaysky writes:
 > Increase of MAX_ADDR_LEN to 8 broke that...

Thank you for this fix.

Later,
David S. Miller
davem@redhat.com
