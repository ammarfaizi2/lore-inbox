Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUBKQSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbUBKQSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:18:37 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:31213 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265886AbUBKQSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:18:36 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16426.21977.976512.628437@laputa.namesys.com>
Date: Wed, 11 Feb 2004 19:18:33 +0300
To: sander@humilis.net
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiserfs for bkbits.net?
In-Reply-To: <20040211161358.GA11564@favonius>
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
	<20040211161358.GA11564@favonius>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander writes:
 > Larry McVoy wrote (ao):
 > > We're moving openlogging back to our offices and I'm experimenting
 > > with filesystems to see what gives the best performance for BK usage.
 > > Reiserfs looks pretty good and I'm wondering if anyone knows any
 > > reasons that we shouldn't use it for bkbits.net. Also, would it help
 > > if the journal was on a different disk? Most of the bkbits traffic is
 > > read so I doubt it.
 > > 
 > > Please cc me, I'm not on the list.
 > 
 > I've cc'ed the Reiserfs mailinglist.
 > 
 > IME Reiserfs is a fast and stable fs. If you have the time to benchmark
 > ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
 > hand which fs is best for you. It might be worth the time.

I can add that concurrent bk clone of kernel repositories is very good
file system stress tool that we are using while debugging reiser4.

 > 
 > With kind regards, Sander
 > 

Nikita.

