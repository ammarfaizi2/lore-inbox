Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277266AbRJQWwe>; Wed, 17 Oct 2001 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277271AbRJQWwY>; Wed, 17 Oct 2001 18:52:24 -0400
Received: from maties2.sun.ac.za ([146.232.128.10]:31886 "EHLO
	maties2.sun.ac.za") by vger.kernel.org with ESMTP
	id <S277266AbRJQWwT>; Wed, 17 Oct 2001 18:52:19 -0400
Date: Thu, 18 Oct 2001 00:52:33 +0200
From: Hugo van der Merwe <hugovdm@mail.com>
To: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse, keyboard conflicts
Message-ID: <20011018005233.A17427@baboon.wilgenhof.sun.ac.za>
Mail-Followup-To: Hugo van der Merwe <hugovdm@mail.com>,
	Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20011017144158.A6534@baboon.wilgenhof.sun.ac.za> <20011017233440.B13317@garloff.casa-etp.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017233440.B13317@garloff.casa-etp.nl>
User-Agent: Mutt/1.3.23i
X-Scanner: exiscan *15tzYC-0003ei-00*SPLe7O2bz82* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the mouse needs to be reinitialized after being replugged. First it needs to

It was plugged in at boot time, is this then still necessary?

> so it got disbaled. You can try reenabling by using the parammeter
> psaux-reconnect and check whether this makes a difference.
> 
> I don't have the slightest clue why it affects yoiur keyboard.

Is there good reason to believe that this is my problem then? How can I
find evidence that supports this theory? Especially interesting was the
days when I could start X and use the ps/2 mouse and keyboard for a
while, before they locked up...

Hugo van der Merwe
