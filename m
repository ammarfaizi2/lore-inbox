Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269800AbUH0AHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269800AbUH0AHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269838AbUH0AG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:06:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:17643 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269800AbUHZX7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:59:46 -0400
Message-ID: <412E7969.8080109@namesys.com>
Date: Thu, 26 Aug 2004 16:59:37 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Spam <spam@tnonline.net>
CC: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net>
In-Reply-To: <742303812.20040826125114@tnonline.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is important is that it all be one packaged solution from the same 
maintainer.  That is necessary for coherency of solution.

There is also benefit to it being one coherent body of code, but this is 
harder to articulate.  It is always hard to articulate why functionality 
belongs in the same program rather than split into multiple programs.  
Filesystems should provide primitives for ordering, structuring, and 
naming objects.  It is hard to say why we should do all of that, but on 
some level I just know it is our task.

Hans

Spam wrote:

>
>
>  You  said  it  would be socially hard. I think it would be very much
>  close to impossible to get it right. Imagine that Gnome and Nautilus
>  would  implement  support  for  these. I doubt that cp, mv, KDE, mc,
>  app-xyz  would  implement  this anytime soon and in the meantime the
>  data is at risk.
>
>
>  
>
>  
>

