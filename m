Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVLFXXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVLFXXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVLFXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:23:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54946
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932543AbVLFXXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:23:09 -0500
Date: Tue, 06 Dec 2005 15:23:16 -0800 (PST)
Message-Id: <20051206.152316.82233251.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
	<20051205.181732.34234732.davem@davemloft.net>
	<Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Tue, 6 Dec 2005 17:10:07 +0100 (CET)

> On Mon, 5 Dec 2005, David S. Miller wrote:
> 
> > 2) You didn't give what the failure mode is for kernels such
> >   as 2.6.14.2, which should work, and certainly don't print out
> >   that bug message
> 
> It's the same as for 2.6.13 and 2.6.15rc, did build a 2.6.14.3 as had 
> removed the 14.2 when I started to use 15rc.

You're still not answering my question, what is this failure
mode?  Xorg doesn't start?  The kernel crashes when Xorg starts?
Xorg starts but you get a blank screen?  You did not mention
this critical information anywhere.  Mentioning a list of other
kernels that "it's the same" for doesn't describe the failure
mode. :)


