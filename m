Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131596AbRAZOvz>; Fri, 26 Jan 2001 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRAZOvq>; Fri, 26 Jan 2001 09:51:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25746 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131447AbRAZOvd>;
	Fri, 26 Jan 2001 09:51:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.36535.775060.43153@pizda.ninka.net>
Date: Fri, 26 Jan 2001 06:50:31 -0800 (PST)
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:  hotmail not dealing with ECN
In-Reply-To: <20010126154613.M3849@marowsky-bree.de>
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net>
	<Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk>
	<14961.25754.449497.640325@pizda.ninka.net>
	<20010126151058.A6331@pcep-jamie.cern.ch>
	<14961.35880.887884.1405@pizda.ninka.net>
	<20010126154613.M3849@marowsky-bree.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lars Marowsky-Bree writes:
 > That would mean that the people worried about this should write a
 > wrapper-library for the connect() call, and maybe add a no_ecn flag to a
 > socket, and leave the kernel alone.

I'm not adding a no_ecn option for sockets.  See my response
to Matti Aarnio earlier today on this list for the
reasons why.

People must fix their firewalls, there is no other way to
fix the problem and get ECN properly deployed.  I'm ceasing
conversation on this thread from this point forward.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
