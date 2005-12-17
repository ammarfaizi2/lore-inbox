Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVLQDqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVLQDqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVLQDqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:46:46 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:35271 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751362AbVLQDqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:46:45 -0500
Date: Sat, 17 Dec 2005 04:47:07 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: 7eggert@gmx.de, Kyle Moffett <mrmacman_g4@mac.com>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <1134761158.18119.9.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0512170442110.2279@be1.lrz>
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it> 
 <E1EnDOo-0006Gd-Na@be1.lrz> <1134761158.18119.9.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005, Lee Revell wrote:
> On Fri, 2005-12-16 at 12:05 +0100, Bodo Eggert wrote:

> > So where is the driver for the Netgear WG511 Softmac card I'm supposed
> > to test? I bought this card because it was labled as being supported, and it
> > turned out that it wasn't, and just nobody cared to update the list of
> > supported cards with the warning about the unsupported variant.
> 
> Um, this is not the developers fault.  Do you think the vendors call the
> driver developers to tell them "hey, we just released a new product,
> with a name confusingly similar to the one your driver supports, but we
> changed the chipset a tiny bit so it won't work with your driver"?
> Dream on.

> Driver developers are not psychic.  If no USER reported that the new
> FooBar1002X is completely different from the FooBar1002, there's no way
> for us to know.  Sorry you were unfortunate enough to be the first user
> to learn the hard way.  Complain to the vendor not LKML.

I found the information hidden on the developer's website, IIRC in the 
developer forum and in several threads. I think it's reasonable to beleave 
that the devteam knew.

-- 
Top 100 things you don't want the sysadmin to say:
90. Wow....that seemed _fast_.....
