Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275378AbTHIUDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275413AbTHIUDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:03:08 -0400
Received: from [66.212.224.118] ([66.212.224.118]:49417 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275378AbTHIUDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:03:04 -0400
Date: Sat, 9 Aug 2003 15:51:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jasper Spaans <jasper@vs19.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix up fs/nfs/inode.c wrt flavo[u]r
In-Reply-To: <20030809195607.GA8171@spaans.vs19.net>
Message-ID: <Pine.LNX.4.53.0308091550010.32166@montezuma.mastecende.com>
References: <shsisp7fzkg.fsf@charged.uio.no> <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
 <20030809004559.GA17257@spaans.vs19.net> <20030809195607.GA8171@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Jasper Spaans wrote:

> On Sat, Aug 09, 2003 at 02:45:59AM +0200, Jasper Spaans wrote:
> > As I stated before, I'll whip up a patch. However, it's 2:45 localtime here
> > right now, and I need to catch some sleep.
> 
> Here goes; this is the least intrusive version I could make which still
> makes sense.
> 
> 
>  fs/nfs/inode.c             |   16 ++++++++--------
>  include/linux/nfs4_mount.h |    4 ++--
>  include/linux/nfs_mount.h  |    2 +-
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> For those who want to look at this without using bitkeeper, a plaintext
> patch is available at 
> 
> http://jsp.vs19.net/tmp/flavour.txt
> 

<whine> *sigh* why not just attach it inline into your email? </whine>

> This BitKeeper patch contains the following changesets:
> 1.1150
> ## Wrapped with uu ##

uu *mumble*

	Zwane
