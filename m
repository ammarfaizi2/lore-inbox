Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136094AbREGNhZ>; Mon, 7 May 2001 09:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136098AbREGNhP>; Mon, 7 May 2001 09:37:15 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:39431 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S136094AbREGNhE>;
	Mon, 7 May 2001 09:37:04 -0400
Date: Mon, 7 May 2001 06:36:57 -0700 (PDT)
From: Zack Brown <zbrown@tumblerings.org>
To: Phillipus Gunawan <mr_phillipus@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Help: kernel-2.4.4 and iptables: Error?
In-Reply-To: <02f101c0d6c9$4b0197a0$d830a4cb@co3042727a>
Message-ID: <Pine.LNX.3.96.1010507063343.8114I-100000@renegade>
MIME-Version: 1.0
Content-Type: MULTIPART/ALTERNATIVE; BOUNDARY="----=_NextPart_000_02EE_01C0D71D.1BDC4DE0"
Content-ID: <Pine.LNX.3.96.1010507063343.8114J@renegade>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------=_NextPart_000_02EE_01C0D71D.1BDC4DE0
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1010507063343.8114K@renegade>

Can someone help this guy?

-- 
Zack Brown

On Mon, 7 May 2001, Phillipus Gunawan wrote:

> I'm having problem with iptables...
> I just upgrade my kernel from 2.2.16 to 2.4.3
> I also upgrade the iptables with: iptables-1.2.1a-1.i386.rpm
> After the installation finished, I try to test it with: iptables -L
> Here's what I've seen on my screen:
> 
> modprobe: Can't locate module ip_tables
> iptables v1.2.1a: can't initialise iptables table 'filter': Module is wrong version
> Perhaps iptables or your kernel needs to be upgraded.
> 
> I install the iptables-1.2.1a-1.i386.rpm first and then upgrade my kernel.
> The way I upgrade my kernel:
> 
> make mrproper
> make dep bzImage
> make modules
> make modules_install
> cp .........
> cp....
> 
> I've choose all option regarding iptables 'netfilter'
> My friend said I might built netfilter with the ipfwadm
> compatibility compiled in, which is mutually exclusive with iptables
> and ipchains support. I didn't build ipfwadm and all other modules I compiled as modules ('M' instead of 'Y')
> 
> But I still can't understand, it still doesn't work...
> 
> Could you please help me. I've tried everywhere asking this question, still, nobody can answer it
> 
> Thank You.
> Best Regards,
> 
> 
> Phillipus.
> 

------=_NextPart_000_02EE_01C0D71D.1BDC4DE0--
