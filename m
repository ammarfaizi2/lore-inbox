Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131391AbRBELsw>; Mon, 5 Feb 2001 06:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131403AbRBELsm>; Mon, 5 Feb 2001 06:48:42 -0500
Received: from sun.rhrk.uni-kl.de ([131.246.137.50]:24017 "HELO
	sun.rhrk.uni-kl.de") by vger.kernel.org with SMTP
	id <S131391AbRBELs1>; Mon, 5 Feb 2001 06:48:27 -0500
Date: Mon, 5 Feb 2001 12:48:08 +0100
From: Dirk Mueller <dmuell@gmx.net>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] NFS and reiserfs
Message-ID: <20010205124808.A18579@rotes20.wohnheim.uni-kl.de>
Mail-Followup-To: Dirk Mueller <dmuell@gmx.net>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A7E40D1.DBCC16E9@cpgen.cpg.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7E40D1.DBCC16E9@cpgen.cpg.com.au>; from jordg@cpgen.cpg.com.au on Mon, Feb 05, 2001 at 04:57:37PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Feb 2001, Grahame Jordan wrote:

> Should I convert all of my NFS filesystems to ext2 or is there another
> option?

If you use kernel 2.4.x: there are patches for NFS support. 


Dirk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
