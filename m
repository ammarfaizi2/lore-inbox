Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUH1Lv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUH1Lv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUH1Lv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:51:27 -0400
Received: from verein.lst.de ([213.95.11.210]:155 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266233AbUH1LvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:51:24 -0400
Date: Sat, 28 Aug 2004 13:51:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828115104.GA11874@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040828111807.GC6746@alias> <20040828112255.GA11569@lst.de> <20040828114628.GD6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828114628.GD6746@alias>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 03:46:28PM +0400, Alexander Lyamin wrote:
> Not true. If true - send bugreports.
> 
> Its work for me couple of months. there were few hiccups, but they got fixed
> quickly by zam@namesys.com. only ext2 partition is /boot cause of BIOS
> limitations. Yes, i use it with LVM2 and stuff...

See the mails from Christophe in this thread.

> > breaks guaranteed fs semantics, it's not going in in either reiser4 or
> > the vfs.
> A
> > 
> > Al has started a thread to hash out working semantics, but there's not been
> > a single namesys person involved.  Similar all of you have absolutely ignore
> Al message had a reply.
> "namesys persons" is Hans Reiser.  Sufficient ?

http://marc.theaimsgroup.com/?t=109355582600002&r=1&w=2

I can't see Hans anywhere.  And honestly Hans has been so out of touch
with VFS internals that some person actually understanding the issue
might be helpfull.  That would probably whoever has taken over Nikita's
position.

