Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUCUO5z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbUCUO5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:57:55 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:4675 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263661AbUCUO5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:57:52 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: root@chaos.analogic.com
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Sun, 21 Mar 2004 14:57:42 +0000
User-Agent: KMail/1.6.1
Cc: Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <200403201433.40357.richard@redline.org.uk> <Pine.LNX.4.53.0403210940380.11483@chaos>
In-Reply-To: <Pine.LNX.4.53.0403210940380.11483@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403211457.42738.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 March 2004 14:46, Richard B. Johnson wrote:
> I have been using 2.4.24 with SMP and hyperthreading with no
> problems. FYI, the reference to Windows is useless, because
> M$ was unable to make any SMP stuff function without crashes
> since windows 2000/professional, later Windows versions don't
> use your additional CPUs at all, they just report that they
> exist. FYI, see if you can find your CPU resources at all
> in XP!!!  They just don't want you to know!

Er, sorry old man, but WindozeXPPro certainly does use the extra processors 
with HT. I'm not talking about Task Manager (which of course shows four 
processors) but the multi-threaded secure gateway application I'm developing 
confirms the multiple (and virtual) processors.

In fact, Windoze2kPro has a different threading kernel to WIndozeXPPro, which 
is why you get four procs in XPPro and only two in 2kPro. Anyway, this isn't 
the thread or forum for this topic. I don't use Doze for anything other than 
compatibility testing so it's a (fairly) moot point. I'm only interested in 
improving Linux (since I develop on and for it) and if this investigation 
helps, then marvellous.

Cheers

R
