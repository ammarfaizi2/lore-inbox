Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUGPNWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUGPNWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGPNWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:22:54 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:35252 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S266548AbUGPNWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:22:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: New mobo question
Date: Fri, 16 Jul 2004 09:22:50 -0400
User-Agent: KMail/1.6
References: <200407160552.27074.gene.heskett@verizon.net> <20040716112007.GA14641@taniwha.stupidest.org> <20040716141521.02c5422f@kingfisher.intern.logi-track.com>
In-Reply-To: <20040716141521.02c5422f@kingfisher.intern.logi-track.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407160922.50109.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.153.127.68] at Fri, 16 Jul 2004 08:22:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 July 2004 08:15, Markus Schaber wrote:
>
>As far as I read him, he wants to build a kernel that runs on his
> new board as well as on his old board.
>
>Basically, he has to just compile a kernel that includes hardware
>support for both chipsets, and all of the other hardware that is on
> the boards. For processor selection, he should find the best
> compromise between both processors (so try to select one that has
> all features that both real processors have in common), and he
> might try the generic X86 optimizations, too.
>
>HTH,
>Markus

I think I'm headed in the right direction, this kernel now has the 
AMD/nforce stuff builtin alongside the VIA.  Invisible  
to /var/log/dmesg.

Both cpu's are athlon XP's but the new one is 2x faster, besides, I 
was losing ground at setiathome, all the new hardware was passing me.  
Gotta play catchup. :-)

Thanks Markus

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
