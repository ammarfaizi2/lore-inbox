Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSKSMlX>; Tue, 19 Nov 2002 07:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSKSMlX>; Tue, 19 Nov 2002 07:41:23 -0500
Received: from ns.suse.de ([213.95.15.193]:64017 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264625AbSKSMlU>;
	Tue, 19 Nov 2002 07:41:20 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, margit@margit.com
Subject: Re: Linux 2.4.19 patch for Suse compatibility
References: <4.3.2.7.2.20021119122403.00b50d70@mail.dns-host.com.suse.lists.linux.kernel> <1037710510.11563.5.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Nov 2002 13:48:23 +0100
In-Reply-To: Alan Cox's message of "19 Nov 2002 13:32:49 +0100"
Message-ID: <p73d6p1vi7c.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Tue, 2002-11-19 at 11:34, Margit Schubert-While wrote:
> > Hi,
> > 	Below is a patch to include an ioctl that Suse kernels use
> > 	at bootup. (Against vanilla 2.4.19)
> > 	Comments ? Can it be included in 2.4.20(-rc*) ?
> 
> This was discussed on the kernel list about four to six weeks ago and
> rejected then as well. See the previous discussion

Actually I don't remember it being rejected, just the discussion dropped off and there was
no suggestion on how to solve the problem this ioctl solves in a better way.

The jury is still out on that one. 

-Andi
