Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWADRgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWADRgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWADRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:36:08 -0500
Received: from xenotime.net ([66.160.160.81]:12707 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965249AbWADRgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:36:07 -0500
Date: Wed, 4 Jan 2006 09:36:03 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Nick Warne <nick@linicks.net>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
In-Reply-To: <200601041728.52081.nick@linicks.net>
Message-ID: <Pine.LNX.4.58.0601040935060.19134@shark.he.net>
References: <200601041710.37648.nick@linicks.net>
 <9a8748490601040918p24674d86j132315e9c8875483@mail.gmail.com>
 <200601041728.52081.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Nick Warne wrote:

> On Wednesday 04 January 2006 17:18, Jesper Juhl wrote:
>
> > > Is there one?
> >
> > No.
> >
> > What you do is you first revert the 2.6.14.5 patch so you are left
> > with a 2.6.14 kernel, then you apply the 2.6.15 patch.
> > For more info, please read Documentation/applying-patches.txt
> > (http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt)
>
> I thought about doing it that way, but convinced myself it was too
> complicated.
>
> I see it is the right way (whatever that is).
>
> I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5

and how did you do that?
Noone supplies such incremental patches AFAIK.

> I suppose I have to backtrack and revert all those patches in order?

No, you can revert 2.6.14.5 directly to 2.6.14.

-- 
~Randy
