Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDGFZj>; Sat, 7 Apr 2001 01:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDGFZ3>; Sat, 7 Apr 2001 01:25:29 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:13324 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S132548AbRDGFZP>; Sat, 7 Apr 2001 01:25:15 -0400
Date: Fri, 6 Apr 2001 22:24:42 -0700
Message-Id: <200104070524.f375Ogh24035@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <3ACE97E0.B95A5748@linux-ide.org>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Apr 2001 21:30:24 -0700, Andre Hedrick <andre@linux-ide.org> wrote:
> 
> You killed yourself....
> 
> You do not have a host that will do idebus=66

You really ought to rename this parameter to pcibus. Even though it doesn't
do justice to the VLB bus, the potential for user error is much smaller.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
