Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRGXALs>; Mon, 23 Jul 2001 20:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRGXALi>; Mon, 23 Jul 2001 20:11:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18566 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265475AbRGXALb>;
	Mon, 23 Jul 2001 20:11:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.48439.66192.538099@pizda.ninka.net>
Date: Mon, 23 Jul 2001 17:11:35 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrew Friedley <saai@swbell.net>, linux-kernel@vger.kernel.org
Subject: Re: pppoe patch in 2.4.7 results - still problem
In-Reply-To: <3B5CBBDD.61365F56@mandrakesoft.com>
In-Reply-To: <000901c112d6$a1a30000$0200a8c0@loki>
	<15196.46734.280781.653712@pizda.ninka.net>
	<3B5CBBDD.61365F56@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Jeff Garzik writes:
 > via-rhine is the only user of skb_copy_and_csum_dev at present;

Right, my bad.

Later,
David S. Miller
davem@redhat.com
