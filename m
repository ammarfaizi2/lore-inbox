Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUH1LXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUH1LXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUH1LXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:23:33 -0400
Received: from verein.lst.de ([213.95.11.210]:33946 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266334AbUH1LXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:23:19 -0400
Date: Sat, 28 Aug 2004 13:22:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: flx@msu.ru, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828112255.GA11569@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040828111807.GC6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828111807.GC6746@alias>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 03:18:07PM +0400, Alexander Lyamin wrote:
> Yes, I think it would be nice to have this infrastructure in VFS. Technically.
> But its not possible, cause of "committee clusterfuck". Socially. Stupidly.

Please explain your problems.  I've not seen a single actually working
proposal yet.  Current reiser4 implementation apparently oopses and
breaks guaranteed fs semantics, it's not going in in either reiser4 or
the vfs.

Al has started a thread to hash out working semantics, but there's not been
a single namesys person involved.  Similar all of you have absolutely ignore
every single technical question or comment but started a flamefest
consisting mostly of personal attacs and "mine is longer" politics. 
