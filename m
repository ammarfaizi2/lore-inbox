Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVCCSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVCCSop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVCCSnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:43:47 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:27499 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261408AbVCCSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:42:05 -0500
Message-Id: <200503031842.AWY46304@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Greg KH'" <greg@kroah.com>, "'David S. Miller'" <davem@davemloft.net>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 10:42:00 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Thread-Index: AcUgDe83JHlKi2QrQ4i2pw46NoINRAAEeapw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In fact, if somebody maintained that kind of tree, especially 
> in BK, it would be trivial for me to just pull from it every once in a 
> while (like ever _day_ if necessary). But for that to work, then that 
> tree would have to be about so _obviously_ not wild patches that 
> it's a no-brainer.

Alan Cox once said he would like to do it:

    > On Mer, 2004-10-27 at 19:37, Hua Zhong wrote:
    > When I said "nobody", I really meant "top kernel developers". I have
not
    > seen anyone step up and say "I'll volunteer to maintain a 2.6 stable
    > release" hence the comment.

    I'll do it if Linus wants

Do you consider having a real stable release maintainer again?

If you want someone to do the job, give him a title. It's a thankless and
boring job, and you can't make it worse by just hiding him somewhere.

How a "stable release maintainer" works for the current model is up to you.
One thought is that he picks up 2.6.x release as a start point and takes
patches to make it stable, then releases it _himself_, not by Linus. Because
the real work is done by him and you need to give him the authority (just
like other Linux 2.x maintainers who release official kernels). But of
course you still pull from his tree to make sure the bug fixes are also
committed to mainline.

Hua

