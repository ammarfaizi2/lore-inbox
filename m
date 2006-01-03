Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWACVPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWACVPy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWACVPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:15:53 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:60371 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S964863AbWACVPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:15:30 -0500
Date: Tue, 3 Jan 2006 22:15:20 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: mark@mtfhpc.demon.co.uk, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20060103.121801.18743523.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0601032213290.2921@lai.local.lan>
References: <Pine.LNX.4.64.0512121127240.12856@lai.local.lan>
 <20051212.142654.62759069.davem@davemloft.net> <Pine.LNX.4.64.0601031456240.25341@lai.local.lan>
 <20060103.121801.18743523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, David S. Miller wrote:

> From: "J.O. Aho" <trizt@iname.com>
> Date: Tue, 3 Jan 2006 15:01:09 +0100 (CET)
>
>> After a small chat at #Gentoo-Sparc at freenode, I thought that I should
>> just say that the problem with X locking up is still there (15-rc7),
>> regardless of gcc version, and that the problem has to do with the UPA
>> code according those who know a lot more than I do.
>
> What "UPA code"?
>
> We don't even have so much as a UPA driver in the Linux kernel.
> So it's hard to know what is being spoken about.  Maybe something
> in the X server?

Nah, the UPA code in the 2.6 kernel, if it had been in the X I hardly can 
think that X had worked under 2.4.


> Perhaps these experts should explain :-)

That could be a lot better if they could post a reply and explaiin so you 
will know what they really are talking about.

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
