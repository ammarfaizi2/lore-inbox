Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUHZGzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUHZGzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 02:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUHZGzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 02:55:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56463 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265195AbUHZGzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 02:55:41 -0400
Date: Wed, 25 Aug 2004 23:53:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Nicholas Miell <nmiell@gmail.com>
Cc: mpm@selenic.com, wichert@wiggy.net, jra@samba.org, akpm@osdl.org,
       spam@tnonline.net, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040825235358.36626f06.pj@sgi.com>
In-Reply-To: <1093496948.2748.69.camel@entropy>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
	<20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net>
	<1093480940.2748.35.camel@entropy>
	<20040826044425.GL5414@waste.org>
	<1093496948.2748.69.camel@entropy>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "OMG! It breaks tar and email!!!" argument doesn't fly. Things break all
> the time and are fixed. It's called progress.

Yes - we break things all the time.  But we take notice, when we are
breaking things, of how long standing and deeply embedded they are.

The deeper the roots, the more respect we show it, and the harder
it will be to change.

Heaping scorn on someone who is reluctant to change something as
deeply embedded as "a file is a byte stream" does not further the
discussion.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
