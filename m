Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313407AbSDGRxW>; Sun, 7 Apr 2002 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313412AbSDGRxV>; Sun, 7 Apr 2002 13:53:21 -0400
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:17088 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S313407AbSDGRxV>; Sun, 7 Apr 2002 13:53:21 -0400
Subject: Re: ReiserFS Bug Fixes 2 of 6
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Hans Reiser <reiser@namesys.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0204061107230.632-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 Apr 2002 13:18:36 -0400
Message-Id: <1018199916.3563.275.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 11:07, Alexander Viro wrote:
> 
> 
> On Sat, 6 Apr 2002, Hans Reiser wrote:
> 
> > 
> > This changeset is to fix reiserfs problems that arose after applying one of
> > Al Viro's cleanup. This changeset simply removes offending part.
> 
> Hans, it's already fixed by Oleg's patch.
> 

Correct.  Hans, numerous people have explained that reversing this patch
fixes nothing.  

-chris


