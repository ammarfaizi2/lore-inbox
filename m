Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265783AbUFDNJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUFDNJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUFDNJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:09:10 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:2754 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265783AbUFDNJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:09:08 -0400
Date: Fri, 4 Jun 2004 15:08:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Hellwig <hch@ucw.cz>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lowered priority of "too many keys" message in atkbd
Message-ID: <20040604130818.GA17261@wohnheim.fh-wedel.de>
References: <20040530083126.GA30916@lst.de> <20040604124811.GC11950@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040604124811.GC11950@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 June 2004 14:48:11 +0200, Pavel Machek wrote:
> 
> > This patch is from the Debian kernel package and I think it's valid
> > because this error doesn't cause any kind of malfunction of the
> > system.
> 
> Except perhaps dropped key?
> 
> When keypress is lost, I like to know if my fingers are to blame,
> keyboard hardware is to blame, or keyboard is misdesigned.

And from experience I can tell, that lossy keyboards are a royal pain
in the behind.  And the system not doing *exactly* what I tell it to
do *is* a malfunction of the system.

"This is bad.  Do you really want to do it? (y/n)"

Just a single wrong key, eh!

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
