Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRANNSV>; Sun, 14 Jan 2001 08:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRANNSH>; Sun, 14 Jan 2001 08:18:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60571 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132807AbRANNRs>;
	Sun, 14 Jan 2001 08:17:48 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.42701.15601.803051@pizda.ninka.net>
Date: Sun, 14 Jan 2001 05:17:01 -0800 (PST)
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <Pine.LNX.4.30.0101141313470.16758-100000@jdi.jdimedia.nl>
In-Reply-To: <14945.38406.478723.657639@pizda.ninka.net>
	<Pine.LNX.4.30.0101141313470.16758-100000@jdi.jdimedia.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Igmar Palsenberg writes:
 > > People must be really suffering right now, and we ought to get
 > > /proc/errno_strings implemented as soon as possible... :-)

 > First the help describing large tables should be changed.

I agree, someone feel free to propose a patch.

 > String errors don't belong in kernel space IMHO.

Thus the smiley in my original email.  I did not mean kernel errno
strings to be taken seriously at all.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
