Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbRAYQl3>; Thu, 25 Jan 2001 11:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130803AbRAYQlT>; Thu, 25 Jan 2001 11:41:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17032 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129873AbRAYQlD>;
	Thu, 25 Jan 2001 11:41:03 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.22256.322768.447815@pizda.ninka.net>
Date: Thu, 25 Jan 2001 08:40:16 -0800 (PST)
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
In-Reply-To: <m3bssvk3xw.fsf@austin.jhcloos.com>
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net>
	<Pine.LNX.4.30.0101251540001.30299-100000@svea.tellus>
	<14960.17652.653140.593056@pizda.ninka.net>
	<m3bssvk3xw.fsf@austin.jhcloos.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James H. Cloos Jr. writes:
 > What exaclty were the issues with the intel cards and sg+csum?
 > 
 > Any idea how much work it'd require to surmount them?

Getting Intel to release full specs on how to make use of
TX hardware checksum assist with the eepro100.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
