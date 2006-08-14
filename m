Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWHNXCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWHNXCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWHNXCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965034AbWHNXCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:02:50 -0400
Message-ID: <44E1010D.7050704@redhat.com>
Date: Mon, 14 Aug 2006 18:02:37 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
References: <44DD00FA.5060600@redhat.com> <20060814155801.fa087b24.akpm@osdl.org>
In-Reply-To: <20060814155801.fa087b24.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 11 Aug 2006 17:13:14 -0500
> Eric Sandeen <esandeen@redhat.com> wrote:
> 
>> (a similar patch could be done for ext2; does anyone in their right mind use ext2 at 16T?
> 
> well, a bug's a bug.  People might want to ue 16TB ext2 for comparative
> performance testing, or because they get their jollies from running fsck or
> something.

ext2 and ext3 have seemingly already diverged a bit, but I suppose no reason to 
let it go further.

>> I'll send an ext2 patch doing the same thing if that's warranted)
> 
> please, when you have nothing better to do ;)

Will do :)

-Eric
