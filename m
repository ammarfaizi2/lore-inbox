Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136529AbRD3WeU>; Mon, 30 Apr 2001 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136531AbRD3WeL>; Mon, 30 Apr 2001 18:34:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136530AbRD3WeC>;
	Mon, 30 Apr 2001 18:34:02 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.59478.418027.725164@pizda.ninka.net>
Date: Mon, 30 Apr 2001 15:33:58 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@suse.cz (Pavel Machek), viro@math.psu.edu,
        linux-kernel@vger.kernel.org (kernel list), torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
In-Reply-To: <E14uM9r-0000Wn-00@the-village.bc.nu>
In-Reply-To: <20010422141042.A1354@bug.ucw.cz>
	<E14uM9r-0000Wn-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Any reason a bad inode can't have its i_sb changed to a bad_inode_fs ?

I believe this is what Linus suggested.

Later,
David S. Miller
davem@redhat.com
