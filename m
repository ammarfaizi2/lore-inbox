Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUJORuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUJORuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUJORuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:50:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24760 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268232AbUJORrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:47:20 -0400
Subject: Re: Fw: signed kernel modules?
From: Josh Boyer <jdub@us.ibm.com>
To: root@chaos.analogic.com
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
References: <27277.1097702318@redhat.com>
	 <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
	 <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
	 <200410151153.08527.gene.heskett@verizon.net>
	 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
	 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1097862366.29988.51.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 12:46:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 11:59, Richard B. Johnson wrote:
> 
> The technical details are that "signed", "sealed", "certified",
> relate to policy. For years policy was not allowed to be included in
> the kernel. In recent times, the kernel has become filthy with
> policy.

I'd disagree.  Do you consider SELinux to be policy as well just because
it's in the kernel?

As David said in his response, it's a mechanism.  Whether _you_ choose
to use it or not decides the "policy".  That's why I said put a config
option around it.  You would still have _choice_.

> it right. What's right for you is wrong for another.

Absolutely.  So why are you trying to prevent people that want to use
module signing from doing so?

josh

