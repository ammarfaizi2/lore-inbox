Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRALILx>; Fri, 12 Jan 2001 03:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRALILo>; Fri, 12 Jan 2001 03:11:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54153 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129655AbRALIL3>;
	Fri, 12 Jan 2001 03:11:29 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.48157.259491.78067@pizda.ninka.net>
Date: Fri, 12 Jan 2001 00:11:09 -0800 (PST)
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Lameter <christoph@lameter.com>, khttpd-users@zgp.org,
        linux-kernel@vger.kernel.org
Subject: Re: khttpd beaten by boa
In-Reply-To: <20010112084259.B441@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com>
	<Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com>
	<20010112084259.B441@marowsky-bree.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lars Marowsky-Bree writes:
 > This just goes on to show that khttpd is unnecessary kernel bloat
 > and can be "just as well" handled by a userspace application, minus
 > some rather very special cases which do not justify its inclusion
 > into the main kernel.

My take on this is that khttpd is unmaintained garbage.

TUX is evidence that khttpd can be done properly and
beat the pants off of anything done in userspace.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
