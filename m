Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbRFATV3>; Fri, 1 Jun 2001 15:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbRFATVT>; Fri, 1 Jun 2001 15:21:19 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:49672 "EHLO
	moisil.badula.org") by vger.kernel.org with ESMTP
	id <S261369AbRFATVC>; Fri, 1 Jun 2001 15:21:02 -0400
Date: Fri, 1 Jun 2001 12:14:55 -0700
Message-Id: <200106011914.f51JEtp04060@moisil.badula.org>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: dobos_s@IBCnet.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP - tcp-hang patch NOT fixed the problem!
In-Reply-To: <OF56FACC45.D8F8889E-ONC1256A5B.004A7C70@ibcnet.hu>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 15:50:22 +0200, dobos_s@ibcnet.hu wrote:

> Today I tried to install freeswan1.9. After establishing ipsec tunnel with
> my peer I got the wait_on_bh message.
> (I cannot paste exactly because It is a production machine, and I restarted
> it as fast as I could)
> 
> So what to do?

Take it up with the freeswan people. It is very likely an SMP bug in their
code.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
