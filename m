Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUJUNQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUJUNQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUJTPxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:53:05 -0400
Received: from gprs214-106.eurotel.cz ([160.218.214.106]:49537 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268446AbUJTPrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:47:37 -0400
Date: Wed, 20 Oct 2004 17:47:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@mru.ath.cx>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Message-ID: <20041020154718.GD26439@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403> <20041018114109.GC4400@openzaurus.ucw.cz> <yw1xekjt4fa8.fsf@mru.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xekjt4fa8.fsf@mru.ath.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> ... and lose all the benefits of HZ=1000.  What would happen if one
> >> >> were to set HZ to a higher value, like 10000?
> >> 
> >> There is a similar issue filed on :
> >> http://bugzilla.kernel.org/show_bug.cgi?id=3406
> >> 
> >
> > He he, someone should write a driver to play music on
> > those capacitors....
> 
> Why not?  They used to have special files that played music on the
> printer when printed.

Yes, it would be nice... to scare people :-). Also with such piece of
software it would be rather easy to tell if given mainboard is junk.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
