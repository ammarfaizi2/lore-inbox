Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315535AbSECLcX>; Fri, 3 May 2002 07:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315633AbSECLcW>; Fri, 3 May 2002 07:32:22 -0400
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:51852 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315535AbSECLcW>; Fri, 3 May 2002 07:32:22 -0400
Subject: Re: [reiserfs-dev] [PATCH] [BK] ReiserFS cleanups (resend #1)
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <200205031106.g43B6Mv04822@bitshadow.namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 May 2002 07:32:08 -0400
Message-Id: <1020425528.1511.98.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-03 at 07:06, Hans Reiser wrote:
> 
> 
> You can pull the changes from our public server at
> 
> bk://thebsh.namesys.com/bk/reiser3-linux-2.5

It would be could if we could get rid of the cset excludes.  They make
the whole thing look a little messy.

ttt is not a good changeset comment ;-)

-chris


