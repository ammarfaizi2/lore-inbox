Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVIJJdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVIJJdI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIJJdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:33:08 -0400
Received: from main.gmane.org ([80.91.229.2]:30647 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750720AbVIJJdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:33:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: 2.6.13 psmouse: problem wheel detection: AlpsPS/2 versus ImPS/2
Date: Sat, 10 Sep 2005 11:29:52 +0200
Message-ID: <1n8tk1hehvpm0$.1leys9nqogxod$.dlg@40tude.net>
References: <200509021327.j82DRJK18844@irsamc.ups-tlse.fr> <20050902141546.GA11506@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-147-119.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005 16:15:46 +0200, Vojtech Pavlik wrote:

> Unfortunately, the ALPS passthrough doesn't allow for imps/2, only ps/2,
> as far as we know. Unfortunately we haven't been able to find a notebook
> with touchpad, touchpoint, *and* an external port, to try to make it
> work.

I have a Dell Inspiron 8200. Like the Latitude of the OP, it has the
DualPoint ALPS and a PS/2 port, so I can help testing, if needed.

I can also get my hands on a 4-button Logitech Trackball (no
scrollwheels or anything, just four buttons), if it can help the
testing.

> I don't think it's possible to have both the ALPS touchpad and an
> external mouse with full functionality. It's one or the other - a
> limitation of the PS/2 protocol, which is designed for one (not three)
> device only

One thing that I noticed under 'the other OS' is that, when an
external PS/2 device is inserted and then disconnected, the 'internal'
ones (keyboard, touchpad) seem to lose sync. It has been some time
since I tried it the last time, so I should probably check again to
see if the extended protocols do work, somehow.

-- 
Giuseppe "Oblomov" Bilotta

Hic manebimus optime

