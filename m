Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265022AbSKAOGf>; Fri, 1 Nov 2002 09:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSKAOGf>; Fri, 1 Nov 2002 09:06:35 -0500
Received: from ns.suse.de ([213.95.15.193]:15879 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265022AbSKAOGe>;
	Fri, 1 Nov 2002 09:06:34 -0500
Date: Fri, 1 Nov 2002 15:13:01 +0100
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       kernel-janitor-discuss@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
Message-ID: <20021101151301.C20859@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrew Morton <akpm@digeo.com>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	kernel-janitor-discuss@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200211011302.05461.arnd@bergmann-dalldorf.de> <3DC25CA5.B15848E0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC25CA5.B15848E0@digeo.com>; from akpm@digeo.com on Fri, Nov 01, 2002 at 02:51:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 02:51:17AM -0800, Andrew Morton wrote:
 > And if you're feeling really keen, Dave Jones has a patch which
 > makes the might_sleep check a real config option rather than
 > overloading CONFIG_DEBUG_KERNEL - would be nice to squeeze that
 > out of him if poss.

Will update to the new kconfig thingy later, and forward it on..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
