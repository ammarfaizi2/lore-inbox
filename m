Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEaAXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEaAXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEaAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:23:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52618 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261727AbVEaAVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:21:17 -0400
Date: Tue, 31 May 2005 02:17:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig
 files (first part) (fwd)
In-Reply-To: <20050531001038.GD3627@stusta.de>
Message-ID: <Pine.LNX.4.61.0505310217030.3728@scrub.home>
References: <20050531001038.GD3627@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 May 2005, Adrian Bunk wrote:

> The main reason for this patch (quoting Jesper) is:
>   Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
>   those entries use "---help---" as the keyword, the rest use just "help". 
>   So the users of "---help---" are clearly a minority and by renaming them 
>   we make things consistent. - I hate inconsistency. :-)

And I still don't like this change...

bye, Roman
