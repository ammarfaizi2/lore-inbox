Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSECLyO>; Fri, 3 May 2002 07:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315646AbSECLyN>; Fri, 3 May 2002 07:54:13 -0400
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:653 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315634AbSECLyM>; Fri, 3 May 2002 07:54:12 -0400
Subject: Re: [reiserfs-dev] [PATCH] [BK] ReiserFS cleanups (resend #1)
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20020503153750.A877@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 May 2002 07:53:59 -0400
Message-Id: <1020426839.1510.124.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-03 at 07:37, Oleg Drokin wrote:
> Hello!
> 
> On Fri, May 03, 2002 at 07:32:08AM -0400, Chris Mason wrote:
> 
> > It would be could if we could get rid of the cset excludes.  They make
> > the whole thing look a little messy.
> 
> Any hints on how to do that?

Heh, this time I'll try to form actual coherent sentences.  The only way
to get rid of the excludes is to export as a patch and redo the bk
tree.  This is a relatively small set of patches, so I think it's worth
it.

> 
> > ttt is not a good changeset comment ;-)
> And ttt was not changeset commet, but one of the checkins comment, I believe.

Yes, sorry.

> 
> Agreed, I just forgot to change it to something more meaningful at commit time,
> and do not know how to change it later ;)

bk comments should do the trick.

-chris


