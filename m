Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTFPPsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTFPPsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:48:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12168 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264015AbTFPPsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:48:05 -0400
Date: Mon, 16 Jun 2003 12:04:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Patrick Mochel <mochel@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: GFDL in the kernel tree
In-Reply-To: <Pine.LNX.4.44.0306160837180.908-100000@cherise>
Message-ID: <Pine.LNX.4.53.0306161157010.18665@chaos>
References: <Pine.LNX.4.44.0306160837180.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Patrick Mochel wrote:

>
> > (3) Documentation/kobject.txt, the other files claims it's under
> >     GFDL but doesn't actually include the license text as mandated
> >     by the GFDL.
> >
> > And of course there's still all those nasty issue with GFDL like
> > invariant sections and cover texts that make at least the debian-devel
> > list believe it's an unfree license..
> >
> > Folks, could we please only use GPL-compatible licenses in the kernel
> > tree?
>
> No problem, I'll remove it from kobject.txt.
>
>
> 	-pat
>

Can someone explain what a "GPL-compatible" license is? Not to
open old sores, but I should be able to provide a license
that states;

 "Anybody can use this text for any purpose whatsoever as long
  as they keep my name within."

However, It has been recently stated that this is not "GPL
compatible",  that you must refer to the exact version of the
"GPL" license to have something "GPL" compatible. This will
prevent a lot of good software from being included within the
kernel, in addition to Linus's software if taken seriously.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

