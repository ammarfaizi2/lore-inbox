Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSJWNHs>; Wed, 23 Oct 2002 09:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264971AbSJWNHr>; Wed, 23 Oct 2002 09:07:47 -0400
Received: from realityfailure.org ([209.150.103.212]:29888 "EHLO
	mail.realityfailure.org") by vger.kernel.org with ESMTP
	id <S264969AbSJWNHp>; Wed, 23 Oct 2002 09:07:45 -0400
Date: Wed, 23 Oct 2002 09:13:51 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: One for the Security Guru's
In-Reply-To: <20021023130251.GF25422@rdlg.net>
Message-ID: <Pine.LNX.4.44.0210230912120.6754-100000@geisha.realityfailure.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Robert L. Harris wrote:

>   I'd like it from the guru's on exactly how bad a hole this really is
> and if there is a method in the kernel that will prevent such exploits.
> For example, if I disable CONFIG_MODVERSIONS is the kernel less likely
> to accept a module we didn't build?  Are there plans to implement some
> form of finger printing on modules down the road?

I seem to recall that there are rootkits with kernel modules out in the 
wild. If I recall correctly, there is a kernel capabilities patch that 
will disallow loading modules after some point.

Its been something I've been meaning to look into more, but with a million 
other projects on the platter ...

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


