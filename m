Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRA2WEe>; Mon, 29 Jan 2001 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbRA2WEY>; Mon, 29 Jan 2001 17:04:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16258 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130325AbRA2WEN>;
	Mon, 29 Jan 2001 17:04:13 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14965.59519.548797.376559@pizda.ninka.net>
Date: Mon, 29 Jan 2001 14:02:39 -0800 (PST)
To: kuznet@ms2.inr.ac.ru
Cc: ionut@cs.columbia.EDU (Ion Badulescu), linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <200101261943.WAA28202@ms2.inr.ac.ru>
In-Reply-To: <Pine.LNX.4.30.0101251253300.20615-100000@age.cs.columbia.edu>
	<200101261943.WAA28202@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > Dave, seems, it is better to repair this. Code really assumes
 > that SG cannot be used without one of CSUM flags...

SG+CSUM requirement is enforced now in my tree, I will publish a newer
zerocopy patch later today.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
