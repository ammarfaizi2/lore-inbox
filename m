Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTJZMkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 07:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTJZMkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 07:40:06 -0500
Received: from linuxhacker.ru ([217.76.32.60]:62401 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263002AbTJZMkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 07:40:03 -0500
Date: Sun, 26 Oct 2003 14:39:25 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: ndiamond@wta.att.ne.jp, vitaly@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
Message-ID: <20031026123925.GA6412@linuxhacker.ru>
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9BA98B.20408@namesys.com> <200310261259.h9QCxhWv004314@car.linuxhacker.ru> <3F9BB870.1010500@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9BB870.1010500@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Oct 26, 2003 at 03:05:04PM +0300, Hans Reiser wrote:
> >HR> Badblocks support is in reiser4, and anyone is welcome to update the 
> >HR> patch for V3, or sponsor us to do it.  We are very low on cash, so we 
> >Actually that v3 patch does not do bad blocks remapping in case of
> >write failure, it only does remapping when you manually ask it.
> >And biggest part of badblocks support in reiser3 is in reiserfsck and tools
> >(and in not that bad shape, last time I looked).
> >As for remapping bad blocks on write failure, the only PC OS that was doing
> >this that comes to my mind is Novell Netware (I think they called it a 
> >"hotfix"
> >or something like that).
> I wasn't saying we would do what is in Netware, and as far as being in 

Sure, I was not claiming this either, but original man seems to be implying
such a feature as something common.

> bad shape is concerned, from the user's point of view it either works or 
> it doesn't.

Sure. And in modern desktop world it does not work (if SMART does not want to
do it).

Bye,
    Oleg
