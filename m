Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVHAHow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVHAHow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVHAHow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:44:52 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:32509 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262410AbVHAHov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:44:51 -0400
Date: Mon, 1 Aug 2005 09:44:47 +0200
From: David Weinehall <tao@acc.umu.se>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, James Bruce <bruce@andrew.cmu.edu>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801074447.GJ9841@khan.acc.umu.se>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Pavel Machek <pavel@ucw.cz>, James Bruce <bruce@andrew.cmu.edu>,
	Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122852234.13000.27.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 07:23:54PM -0400, Lee Revell wrote:
> On Mon, 2005-08-01 at 00:47 +0200, Pavel Machek wrote:
> > I'm pretty sure at least one distro will go with HZ<300 real soon now
> > ;-).
> > 
> 
> Any idea what their official recommendation for people running apps that
> require the 1ms sleep resolution is?  Something along the lines of "Get
> bent"?

Calm down.  Any argument along the lines of the change of a default
value in the defconfig screwing people over equally applies the other
way around; by not changing the defconfig, you're screwing laptop users
(and others that want less power consumption) over.  The world is not
black and white, it's a very boring gray (or a very sadening bloody
red; but I hope we won't come to that point just because of a silly
argument on lkml...)

In the end, Linus will decide this anyway.  I can understand that you
don't want to change your application.  Help developing the dynamic
tick patch, and maybe you won't have to =)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
