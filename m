Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAZAis>; Thu, 25 Jan 2001 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRAZAii>; Thu, 25 Jan 2001 19:38:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17292 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129172AbRAZAi3>;
	Thu, 25 Jan 2001 19:38:29 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.50897.494908.316057@pizda.ninka.net>
Date: Thu, 25 Jan 2001 16:37:37 -0800 (PST)
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
In-Reply-To: <m3itn3i5iu.fsf@austin.jhcloos.com>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net>
	<200101251905.f0PJ5ZG216578@saturn.cs.uml.edu>
	<14960.31423.938042.486045@pizda.ninka.net>
	<20010125115214.D9992@draco.foogod.com>
	<m3itn3i5iu.fsf@austin.jhcloos.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James H. Cloos Jr. writes:
 > Are there any well know sites using ECN we can test against?

Use non-passive FTP to my workstation and just do a directory listing
which will make the FTP server create a TCP connection back to your
machine for the transfer of the directory listing.

My workstation is pizda.ninka.net, please everyone be nice.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
