Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUH1Lqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUH1Lqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUH1Lqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:46:39 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:5384 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S266014AbUH1Lqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:46:34 -0400
Date: Sat, 28 Aug 2004 15:46:28 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re:  reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828114628.GD6746@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040828111807.GC6746@alias> <20040828112255.GA11569@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828112255.GA11569@lst.de>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 28, 2004 at 01:22:55PM +0200, Christoph Hellwig wrote:
> On Sat, Aug 28, 2004 at 03:18:07PM +0400, Alexander Lyamin wrote:
> > Yes, I think it would be nice to have this infrastructure in VFS. Technically.
> > But its not possible, cause of "committee clusterfuck". Socially. Stupidly.
> 
> Please explain your problems.  I've not seen a single actually working
> proposal yet.  Current reiser4 implementation apparently oopses and

Not true. If true - send bugreports.

Its work for me couple of months. there were few hiccups, but they got fixed
quickly by zam@namesys.com. only ext2 partition is /boot cause of BIOS
limitations. Yes, i use it with LVM2 and stuff...

de facto its even more stable then reiserfs 3.6, which got issues with
CONFIG_PREEMPT.

> breaks guaranteed fs semantics, it's not going in in either reiser4 or
> the vfs.
A
> 
> Al has started a thread to hash out working semantics, but there's not been
> a single namesys person involved.  Similar all of you have absolutely ignore
Al message had a reply.
"namesys persons" is Hans Reiser.  Sufficient ?

> every single technical question or comment but started a flamefest
> consisting mostly of personal attacs and "mine is longer" politics. 
no need to comment on this.

-- 
"the liberation loophole will make it clear.."
lex lyamin
