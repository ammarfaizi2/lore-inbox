Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTGNU2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTGNU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:27:58 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:5138 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270803AbTGNUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:25:57 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + nvidia 4363 driver
Date: Mon, 14 Jul 2003 21:36:49 +0100
User-Agent: KMail/1.5.2
References: <200307142134.52068.gregora@web.de>
In-Reply-To: <200307142134.52068.gregora@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307142136.51191.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 Jul 2003 20:34, Anich Gregor wrote:
> >
> > Just a quick hack to the official unofficial patch!  It's working OK for
> > me right now.  You'll need to apply the 2.5 patch then this one
> > afterwards.
>
> Seems like some people have problems applying your patch.

Strange you should say that as yours is the only reply I've seen.  Is there 
somewhere else that someone is saying they're having problems?

> I have put up a small howto how to compile the NVIDIA_kernel
> with linux-2.6 at
> http://deltaanime.ath.cx/~blight/nvidia_kernel_with_2.6.html The only thing
> what breaks it is that the version is no longer below 2, 6, 0 which the 2.5
> patch uses to check wether it's 2.5 or not ;)

Yes, I know that works, but I felt like extending the definitions instead of 
making it treat 2.5 and 2.6 as if they're identical.  OK, they probably will 
be now, but I've never likes taking things for granted.

-- 
Ian.

