Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFIUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFIUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:43:29 -0400
Received: from pdbn-d9bb86da.pool.mediaWays.net ([217.187.134.218]:8456 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S261928AbTFIUn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:43:28 -0400
Date: Mon, 9 Jun 2003 22:56:51 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Shawn <core@enodev.com>
Cc: "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cachefs on linux
Message-ID: <20030609205650.GA11518@citd.de>
References: <Pine.LNX.4.44.0306091624370.14854-100000@volga.dcc.ufmg.br> <20030609204249.GA11373@citd.de> <1055191776.13435.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055191776.13435.6.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:49:36PM -0500, Shawn wrote:
> On Mon, 2003-06-09 at 15:42, Matthias Schniedermeyer wrote:
> > On Mon, Jun 09, 2003 at 04:26:01PM -0300, Leonardo H. Machado wrote:
> > > Why has Solaris a CacheFS file system, while linux doesn't?
> > 
> > Is this a "You don't know it, you don't need it" thing?
> Well, it's a nice way to simulate writing on r/o filesystems IIRC. Like
> mounting a cdrom then writing to it, but you're not.
> 
> Was that was this was? Anyway, linux also does not have unionFS. If it
> was that big of a deal, someone would write it. As it is, it's a
> whizbang no one cares about enough.

I remember this as "translucent"<whatever>.

IIRC you can do this with "bind"-mounting the writeable-dir over the
read-only dir, but that's from rusted memory, maybe i'm wrong.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

