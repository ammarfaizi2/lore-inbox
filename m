Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUJOVJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUJOVJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUJOVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:09:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:2978 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268370AbUJOVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:09:21 -0400
Subject: Re: Fw: signed kernel modules?
From: Lee Revell <rlrevell@joe-job.com>
To: root@chaos.analogic.com
Cc: David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       gene.heskett@verizon.net, Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
References: <27277.1097702318@redhat.com>
	 <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
	 <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
	 <200410151153.08527.gene.heskett@verizon.net>
	 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
	 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
	 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1097873791.5119.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 16:56:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 13:35, Richard B. Johnson wrote:
> You just don't get it. This is policy.
> 
> Script started on Fri 15 Oct 2004 01:13:59 PM EDT
> # insmod xxx.ko
> xxx: module license 'BSD' taints kernel.
> # exit
> Script done on Fri 15 Oct 2004 01:14:26 PM EDT

OK, now _this_ is undeniably policy, I would go so far as to call it
bullshit.  There is a fundamental technical reason to have closed source
modules taint the kernel, because you cannot debug a closed source
module.  But come on, a BSD license tainting the kernel?  That is
zealotry, pure and simple.

Lee 

