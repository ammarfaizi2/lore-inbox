Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVI0Xda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVI0Xda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVI0Xda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:33:30 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63406 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751160AbVI0Xd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:33:29 -0400
Subject: Re: Strange disk corruption with Linux >= 2.6.13
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050927111038.GA22172@ime.usp.br>
References: <20050927111038.GA22172@ime.usp.br>
Content-Type: text/plain; charset=iso-8859-1
Organization: Cyclades
Message-Id: <1127863912.4802.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 28 Sep 2005 09:31:52 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rogerio.

On Tue, 2005-09-27 at 21:10, Rogério Brito wrote:
> Hi there. I'm seeing a really strange problem on my system lately and I
> am not really sure that it has anything to do with the kernels.

I've seen the thread mostly following the hardware line. I'd like to
enquire down the kernel path because I've seen occasional, impossible to
reproduce problems too.

Can I ask first a few questions:

1) Are you using vanilla kernels, or do you have other patches applied?
2) Are you using ext3 only?
3) Is the corruption only ever in memory, or seen on disk too?
4) Is the corruption only in one filesystem or spread across several (if
applicable)? (ie in / but not /home or others?)

Regards,

Nigel


