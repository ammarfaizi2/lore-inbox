Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVAWUH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVAWUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVAWUH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:07:28 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:60432 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261354AbVAWUHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:07:22 -0500
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Organization: None
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: System beeper - no sound from mobo's own speaker
Date: Sun, 23 Jan 2005 20:07:21 +0000
User-Agent: KMail/1.6.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200501231937.53099.stephen@g6dzj.demon.co.uk> <20050123225010.0172a6e0.vsu@altlinux.ru>
In-Reply-To: <20050123225010.0172a6e0.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200501232007.21027.stephen@g6dzj.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 Jan 2005 19:50, Sergey Vlasov wrote:

Hi Sergey,

You know - I've just found that and yes it does help on one system, so I'm 50% 
better off - just need to find out where to put the command so that it loads 
it on startup...modules.conf would be it I guess.

Thanks for quick reply.

Steve
> On Sun, 23 Jan 2005 19:37:53 +0000 Stephen Kitchener wrote:
> > I seem to have a problem that, in that when I am using the kernel
> > supplied with Mandrake 10.0 and 10.1 and also fedora 3, there seems to be
> > a distinct lack of beeps coming from the system, once it is up and
> > running. I am NOT talking about sounds that might be coming from any
> > sound card that might be connected to the system, but the plain old
> > speaker that sits in the PC case.
>
> Does "modprobe pcspkr" help?  In 2.6.x kernels the PC speaker support
> can be built as a loadable module; probably the startup scripts do not
> load it automatically.

-- 
                 O  o
            _\_   o
         \\/  o\ .
         //\___=
            ''
Sun, 23 Jan 2005 20:04:43 +0000
 20:04:43 up 10:19,  0 users,  load average: 1.24, 1.14, 1.10
The crying baby on board your flight is always seated next to you
		-- Murphy's Laws for Frequent Flyers n°8
