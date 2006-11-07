Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754232AbWKGSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbWKGSPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbWKGSPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:15:17 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:20193 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751360AbWKGSPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:15:15 -0500
Date: Tue, 7 Nov 2006 19:14:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107181408.GE29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <1162922488.28425.51.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162922488.28425.51.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 13:01:28 -0500, Jeff Layton wrote:
> 
> Thanks for the feedback. Yeah, I held back on converting any filesystems
> until I had some comments. Thanks for doing the legwork on that part.
> Here's a respun patch with the suggested modification to
> new_inode_autonum. This also adds it to fs.h.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
Acked-by: Joern Engel <joern@wh.fh-wedel.de>

Looks good to me.

Jeff, would you mind taking my patches and putting them into a decent
patch series?  I really should be working on other things.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
