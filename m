Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbSITRBG>; Fri, 20 Sep 2002 13:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbSITRBG>; Fri, 20 Sep 2002 13:01:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:30140 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263012AbSITRBF>;
	Fri, 20 Sep 2002 13:01:05 -0400
Message-ID: <3D8B557C.F9BF34D3@digeo.com>
Date: Fri, 20 Sep 2002 10:06:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: New version of the ext3 indexed-directory patch
References: <E17sQq8-00045P-00@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 17:06:05.0090 (UTC) FILETIME=[01463820:01C260C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 
> I've done a bunch of hacking on the ext3 indexed directory patch, and I
> believe it's just about ready for integration with the 2.5 tree.

Thanks; it's good that this is moving ahead.  I'll update to this
version in the -mm patchkit, so people can test it from there
too.

What is the status of e2fsprogs support for htree?  Is everything covered?
