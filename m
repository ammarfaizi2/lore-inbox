Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUBSQGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSQGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:06:15 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:14214 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267325AbUBSQF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:05:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with alsa, emu10k1 and ut2003 on 2.6.3
In-Reply-To: <1077197950.4034bc7ec9730@imp1-q.free.fr>
References: <1077197950.4034bc7ec9730@imp1-q.free.fr>
Date: Thu, 19 Feb 2004 11:07:32 -0500
Message-Id: <E1Atqi4-0000BM-7q@torg>
From: Tyler Trafford <ttrafford@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:

> I have a strange problem with the sound on my PC [1] with the kernel
> 2.6.3 when I play to unreal tournement 2003. I use the same
> configuration as the 2.6.1 which work quite well on my computer.
>
> When I play to UT2003, sounds are not clean : there is some crackling.
> Moreover, the music is played two or three time faster than normally.
> As I haven't got this problem with 2.6.1, I imagine that it can be a
> problem with the new alsa version.

This is a problem with the openal.so library that comes with UT2003.  To
fix it you can replace it with one from America's Army or UT2004; or you
can just compile yourself a new one from cvs (www.openal.org).
-- 
Tyler Trafford

Loneliness is a terrible price to pay for independence.
