Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUDQKGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUDQKFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:05:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:21260 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263784AbUDQKEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:04:23 -0400
Date: Sat, 17 Apr 2004 12:04:03 +0200
From: Willy Tarreau <w@w.ods.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support in 2.4.27
Message-ID: <20040417100403.GB16284@alpha.home.local>
References: <20040417080403.GF596@alpha.home.local> <Pine.LNX.4.10.10404170247330.22035-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10404170247330.22035-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 02:48:04AM -0700, Andre Hedrick wrote:
> 
> Willy,
> 
> See you get it ... just patch and go ... what is the problem, heh?

Andre,

There's no problem. I just do not make the confusion between mainline, which
should keep compatible, and "add-ons" which sometimes can break compatibility
with mainline, but which are targetted at experienced users. I'm happy that
SATA goes into mainline IF it does not rename drives which currently work in
earlier releases. That does not prevent me from using more advanced features
and be prepared to change fstab and lila.confo on a particular machine
if/when I upgrade. Mainline is *the* reference that even newbies can use
for blind upgrades without risk. Fortunately, there are lots of wonderful
things around to complete this stable reference.

Cheers,
Willy

