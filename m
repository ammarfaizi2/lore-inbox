Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291399AbSBHEI5>; Thu, 7 Feb 2002 23:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291400AbSBHEIr>; Thu, 7 Feb 2002 23:08:47 -0500
Received: from out016pub.verizon.net ([206.46.170.92]:56743 "EHLO
	out016.verizon.net") by vger.kernel.org with ESMTP
	id <S291399AbSBHEIi>; Thu, 7 Feb 2002 23:08:38 -0500
Date: Thu, 7 Feb 2002 23:06:14 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Alpha update for 2.5.3
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020208015826.JIFG11848.out009.verizon.net@pool-141-150-235-204.delv.east.verizon.net> <Pine.LNX.4.10.10202071952340.15165-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10202071952340.15165-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Thu, Feb 07, 2002 at 07:53:11PM -0800
Message-Id: <20020208040837.MDKA24823.out016.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> That code path will go away!
> That is a diagnostic path only.

Sorry Jeff, and others, if that's the wrong patch.  It fixed the compile
error for ide-dma so I used it.  I still haven't been able to test it
due to link errors with bus_to_virt.

So if Andre is saying don't use it, then don't.  My apologies.

-- 
Skip
