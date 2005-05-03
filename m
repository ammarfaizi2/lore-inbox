Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVECKNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVECKNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVECKNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:13:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18603 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261443AbVECKNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:13:05 -0400
Date: Tue, 3 May 2005 12:09:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig
 files (first part)
In-Reply-To: <20050503092202.GC3592@stusta.de>
Message-ID: <Pine.LNX.4.61.0505031202080.996@scrub.home>
References: <20050503003400.GO3592@stusta.de> <Pine.LNX.4.61.0505031107120.996@scrub.home>
 <20050503092202.GC3592@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 May 2005, Adrian Bunk wrote:

> The separator used for the help is to indent help texts by two 
> additional spaces.

Yes, that's an additional indicator.

> IMHO, Kconfig files are quite readable due to this indentation even 
> though only a minority of the entries was using "---help---" even 
> before this patch.

So why exactly has to be removed? Is it ugly? Does it make Kconfig worse?
Sorry, but only because it's not used that often, is not enough of a 
reason for me to remove it. If it helps only a little bit to spot the help 
text start easier, it's IMO worth to keep it.

bye, Roman
