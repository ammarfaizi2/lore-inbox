Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTHFRIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHFRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:08:54 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:21671 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S270806AbTHFRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:08:18 -0400
Date: Wed, 6 Aug 2003 13:08:01 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Steve Dickson <SteveD@redhat.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] kNFSd: Fixes a problem with inode clean up for
 vxfs
In-Reply-To: <3F3128A4.8030305@RedHat.com>
Message-ID: <Pine.LNX.4.44.0308061306380.18793-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Steve Dickson wrote:

> This a patch I've received from Veritas. Supposedly they have
> already submitted this but I can't seem to find it in any 2.4 trees..
> 
> Does anybody recognize this and are there any known issues with it?

It makes me wonder what is so special about vxfs that they need
to modify GPL code in order for it to work ...

Not that I'm against this change in principle, but I'd just like
it to be useful for GPL software too, otherwise it'd just be a
hook for non-GPL software and a fine line to a GPL violation.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

