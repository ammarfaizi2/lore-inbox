Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263048AbTCWM3C>; Sun, 23 Mar 2003 07:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTCWM3C>; Sun, 23 Mar 2003 07:29:02 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:4848 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263048AbTCWM3B>; Sun, 23 Mar 2003 07:29:01 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5 AGP no good (VIA KT333, radeon 7500)
Date: Sun, 23 Mar 2003 13:40:00 +0100
User-Agent: KMail/1.5.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231340.00473.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 March 2003 16:38, you wrote:
> On Fri, Mar 21, 2003 at 04:15:28PM +0100, Duncan Sands wrote:
>  > X-windows starts, but the picture is horribly torn, only the grey
>  > stipple pattern is recognizable.  Any thoughts?  Or should I start a
>  > binary search for the last version that worked?
>
> Strange, and this only happens when you have agpgart loaded ?

It was a BIOS problem: I flashed it, and the problem has gone
(the agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
messages have gone too).  The strange thing is, there was no
problem with 2.4 even before flashing the BIOS.

All the best,

Duncan.
