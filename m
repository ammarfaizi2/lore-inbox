Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbTC1Ugc>; Fri, 28 Mar 2003 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbTC1Ugc>; Fri, 28 Mar 2003 15:36:32 -0500
Received: from tomts21-srv.bellnexxia.net ([209.226.175.183]:37823 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263133AbTC1Uga>; Fri, 28 Mar 2003 15:36:30 -0500
Date: Fri, 28 Mar 2003 15:42:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: any resolution of keyboard problems?
In-Reply-To: <20030328122349.55f76130.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0303281541540.1124-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Randy.Dunlap wrote:

> On Fri, 28 Mar 2003 15:03:06 -0500 (EST) "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> 
> |   i just downloaded the bk4 set of patches for 2.5.66 to see if
> | anything has changed with respect to the weird keyboard problems
> | i was having with my dell laptop and its external PS/2 keyboard.
> | 
> |   has anyone else been seeing this?  do any of the patches
> | in the bk4 snapshot address this?  i'm recompiling as we speak,
> | and i'll test it again as soon as i can.
> 
> I looked at the config file that you posted and didn't see
> any glaring issues with it, but then I don't have a Dell laptop
> either.
> 
> You might have to find an earlier kernel that works and then
> find where it breaks.  Or turn off some big things, like APM
> (just for testing).

i turned off most of what i could think of to try to isolate the
problem.  i'll poke around more later with the latest build.

rday

