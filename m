Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNVT5>; Thu, 14 Dec 2000 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbQLNVTr>; Thu, 14 Dec 2000 16:19:47 -0500
Received: from moot.mb.ca ([64.4.83.10]:64520 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129773AbQLNVTm>;
	Thu, 14 Dec 2000 16:19:42 -0500
Date: Thu, 14 Dec 2000 14:49:14 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 + DHCP + nfsroot
Message-ID: <Pine.LNX.4.21.0012141434270.9058-100000@sliver.moot.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problems getting my machines to load nfsroot since I went from
2.2.16 -> 2.2.18. I don't have access to the boot messages, as the
machines are 2000 miles away, but the DHCP messages aren't showing up
anymore, but instead a bunch of RPC messages are. Has anything changed
with regards to DHCP or nfs root since 2.2.17?

Thanks in advance.

,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.ca   Work: (204) 982-1060
; mjd@moot.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
