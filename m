Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWACOBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWACOBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWACOBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:01:23 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:19617 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1751411AbWACOBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:01:23 -0500
Date: Tue, 3 Jan 2006 15:01:09 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: mark@mtfhpc.demon.co.uk,
       linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051212.142654.62759069.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0601031456240.25341@lai.local.lan>
References: <DGEKIABPPPEBAOMKAJCEKEAKCBAA.mark@mtfhpc.demon.co.uk>
 <Pine.LNX.4.64.0512121127240.12856@lai.local.lan> <20051212.142654.62759069.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Mon, 12 Dec 2005 11:38:32 +0100 (CET)
>
>> I have been using gcc-3.3.5 (64bits) when building the kernel, today
>> I did upgrade to gcc-3.3.6 (64bits), but still have the same problem
>> with the X11.  For build normal system applications and tools I have
>> gcc-3.3.6 (32bit).
>
> I use gcc-4.0.2 and gcc-3.4.5 for all of my kernel builds.

After a small chat at #Gentoo-Sparc at freenode, I thought that I should 
just say that the problem with X locking up is still there (15-rc7), 
regardless of gcc version, and that the problem has to do with the UPA 
code according those who know a lot more than I do.

Thanks again for all help.

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
