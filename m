Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWBZRUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWBZRUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWBZRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:20:39 -0500
Received: from mail.linicks.net ([217.204.244.146]:35488 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751275AbWBZRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:20:38 -0500
From: Nick Warne <nick@linicks.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Date: Sun, 26 Feb 2006 17:20:34 +0000
User-Agent: KMail/1.9.1
Cc: "Mark Lord" <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <200602261308.47513.nick@linicks.net> <4401E06D.90305@rtr.ca> <9a8748490602260917h31883941qa46dea626276d389@mail.gmail.com>
In-Reply-To: <9a8748490602260917h31883941qa46dea626276d389@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261720.34062.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 17:17, Jesper Juhl wrote:

> > But perhaps someone may successfully implement this.
>
> Unfortunately my machines only have SCSI devices, so I'd have no way
> to actually test a patch, otherwise I'd be happy to give it a shot - a
> parameter to disable the behaviour shouldn't be too difficult to
> implement, and if the default stays as the current behaviour then it
> shouldn't be too controversial.
> I wouldn't mind trying to hack up a patch, but it would be untested...

Post it to me - but look at my original post - this is/was on kernel 2.4.32.  
I have yet to see such output on 2.6.x series kernels.

I could test that for you, as I have a test box at work running 2.4.32 that 
gets these strange disk errors sometimes (never have nailed that one down).

Nick

-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
