Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSKPC4H>; Fri, 15 Nov 2002 21:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSKPC4H>; Fri, 15 Nov 2002 21:56:07 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:43274 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S267210AbSKPC4H>; Fri, 15 Nov 2002 21:56:07 -0500
Date: Sat, 16 Nov 2002 14:01:07 +1100
From: john slee <indigoid@higherplane.net>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Thomas Molina <tmolina@cox.net>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021116030106.GF17478@higherplane.net>
References: <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina> <Pine.LNX.4.44.0211142252590.13759-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211142252590.13759-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:58:09PM -0500, Patrick Finnegan wrote:
> It'd be nice if people simply tried compiling a patched kernel (all
> affected modules) before they submitted the patch, I'm betting you'd catch
> a lot of typos.  Also, compiling _everything_, even as a module, at
> least once before sumbitting the patch would probably help.

thats fine if there is an all-compiling kernel release out there.  right
now 2.5-bk is far from it.  last i checked allmodconfig (a couple of
days ago) there was major breakage all over llc, scsi, video, sound, ...
which kinda masks any breakages you might have introduced.  these sort
of things get fixed in time, but they are often replaced by new ones in
other places

j.

-- 
toyota power: http://indigoid.net/
