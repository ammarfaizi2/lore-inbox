Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137051AbREKFgw>; Fri, 11 May 2001 01:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137053AbREKFgn>; Fri, 11 May 2001 01:36:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10133 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137051AbREKFge>;
	Fri, 11 May 2001 01:36:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.31325.228963.52019@pizda.ninka.net>
Date: Thu, 10 May 2001 22:36:29 -0700 (PDT)
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Duncan Gauld <duncan@gauldd.freeserve.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible README patch
In-Reply-To: <Pine.LNX.4.21.0105101754080.283-100000@presario>
In-Reply-To: <20010505102133.A16788@flint.arm.linux.org.uk>
	<Pine.LNX.4.21.0105101754080.283-100000@presario>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anuradha Ratnaweera writes:
 > 
 > On Sat, 5 May 2001, Russell King wrote:
 > 
 > > gzip -dc linux-2.4.XX.tar.gz | tar zvf -
 > > gzip -dc patchXX.gz | patch -p0
 > 
 > This does _not_ work for international kernel patch. They assume the
 > directories lin.2.x.x/ (old) and int.2.x.x/ (new) and not linux/.
 > Therefore it _is_ necessary to `cd linux' and do a `patch -p1'.

Yes, but this document is about the official final patches Linus and
Alan release for 2.2.x and 2.4.x, not about arbitrary kernel patches
that are available.

Later,
David S. Miller
davem@redhat.com

