Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVK0OpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVK0OpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVK0OpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:45:04 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:63408 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751084AbVK0OpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:45:02 -0500
Date: Sun, 27 Nov 2005 16:44:57 +0200
From: Ville Herva <vherva@vianova.fi>
To: Sander <sander@humilis.net>
Cc: 7eggert@gmx.de, Adrian Bunk <bunk@stusta.de>,
       Folkert van Heusden <folkert@vanheusden.com>,
       linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051127144457.GB6966@vianova.fi>
Reply-To: vherva@vianova.fi
References: <5bG4q-8ks-17@gated-at.bofh.it> <5daDm-1Cg-15@gated-at.bofh.it> <5de3Z-6CJ-13@gated-at.bofh.it> <E1EgB4G-00013Z-9E@be1.lrz> <20051127121604.GA6966@vianova.fi> <20051127135541.GA5928@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127135541.GA5928@favonius>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 02:55:41PM +0100, you [Sander] wrote:
> 
> Maybe 'gorc' can help you. I don't have an url, but it is package 'gorc'
> in Debian.
> 
> I had little success with a digicam photo of lightgray text on
> not-quite-white paper, even after trying to improve things with gimp,
> but it might work if you have the oops on screen.

Seems promising, but the results are not that great. See

http://v.iki.fi/~vherva/tmp/shot.png 
and
http://v.iki.fi/~vherva/tmp/shot.txt

the gray level setting didn't help much.
 
> Then again, if you have it on screen, you might as well put it on the
> web.

Sometimes you need to ksymoops the dump (for older kernels) or paste some
parts to some program.

In theory, converting a vga text screen capture shouldn't be hard, but in
practise... Well, it's much more beneficial to me to learn to type
passably...


-- v -- 

v@iki.fi

