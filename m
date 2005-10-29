Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVJ2LRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJ2LRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVJ2LRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:17:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11958 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750968AbVJ2LRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:17:49 -0400
Date: Sat, 29 Oct 2005 12:17:48 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14
Message-ID: <20051029111748.GA6074@gallifrey>
References: <4362C255.30600@oxley.org> <200510290042.j9T0gsg28096@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510290042.j9T0gsg28096@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 12:14:42 up 56 days, 23:40, 65 users,  load average: 0.00, 0.03, 0.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Have you any idea what happened to cpu-fp on the Dual Xeons?
Accross the other 2 platforms it is pretty stable, but cpu-fp
seems to have gone up a few % around 2.6.13-rc7 and dropped back
down around 2.6.1.4-rc2 and 2.6.14-rc4; now it isn't any lower
than where you started - but it would be nice to have whatever
it was that got that extra few %.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
