Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbUBXCbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUBXCbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:31:23 -0500
Received: from intra.cyclades.com ([64.186.161.6]:31928 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262095AbUBXCbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:31:22 -0500
Date: Tue, 24 Feb 2004 00:24:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: 2.4.25 Ooops & crash
In-Reply-To: <Pine.LNX.4.58LT.0402201652320.2690@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.58L.0402240015150.5692@logos.cnet>
References: <Pine.LNX.4.58LT.0402201652320.2690@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Lukasz Trabinski wrote:

> Hello

Hi Lukasz,

> I have unlucky with latest 2.4.25 kernel. Most of my machines after
> upgrade kernel to 2.4.25 (from 2.4.24) automatically restart after several
> hours, or Ooops (swapper proces, pid 0).
> In logs file i haven't any information from kernel (oops and other strange
> thing). Unfortunately i can't connect serial console to catch information
> from console. :(
>
> With 2.4.24 or earlier i had uptime about 50-100 days (except one machine)
> I don't see any reports about this problem on this list, strange.

Right, I haven't received any reports of problems like yours in 2.4.25.

Is there any common hardware between this machines? aic7xxx I suspect?

Please collect more details --- the oops output would be great.

Why can't you connect a serial cable to any of the machines?

> On http://lukasz.eu.org/2.4.25-rc1 you can see ksymoops.txt or vmlinux
> from machine where i tested 2.4.25-rc1.

There is nothing wrong in these traces AFAICS.


