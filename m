Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRIYTCs>; Tue, 25 Sep 2001 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272588AbRIYTCj>; Tue, 25 Sep 2001 15:02:39 -0400
Received: from mons.uio.no ([129.240.130.14]:20432 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272265AbRIYTCX>;
	Tue, 25 Sep 2001 15:02:23 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251430330.24321-100000@weyl.math.psu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Sep 2001 21:02:40 +0200
In-Reply-To: Alexander Viro's message of "Tue, 25 Sep 2001 14:34:01 -0400 (EDT)"
Message-ID: <shshetr3xgv.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > OK, let me put it that way: we need to turn stat() into method
     > call rather than blind access to inode fields.  Then all these
     > problems will be very easy to deal with.

Yes *please*! Finally we could introduce proper support for 64-bit
inode numbers too!

Cheers,
  Trond
