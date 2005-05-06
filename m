Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVEFTNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVEFTNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 15:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEFTNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 15:13:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50051 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261272AbVEFTNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 15:13:42 -0400
Subject: Re: [git pull] jfs update
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, jgarzik@pobox.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505123953.4a45a834.akpm@osdl.org>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
	 <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
	 <427A630E.5000008@pobox.com>
	 <Pine.LNX.4.58.0505051119440.2328@ppc970.osdl.org>
	 <1115319068.8473.5.camel@localhost> <20050505123953.4a45a834.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 May 2005 14:13:39 -0500
Message-Id: <1115406819.10460.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 12:39 -0700, Andrew Morton wrote:
> Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> >
> > Andrew,
> >  You can pull:
> > 
> >  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-mm
> > 
> >  whenever you do an -mm build.  If your scripts have a problem with that,
> >  you might try
> > 
> >  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git#for-mm
> 
> Neither of those work for me, which I guess means that I have to go and
> update all my git stuff, whcih will break every darn thing.  Ho hum.

If you haven't already, don't rush on my account.  I don't need to put
anything in that tree newer than what I want in -mm, so you can use:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git

In other words, I don't have any problem leaving HEAD equal to
HEAD-for-mm.
-- 
David Kleikamp
IBM Linux Technology Center

