Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUFAWYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUFAWYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUFAWYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:24:25 -0400
Received: from main.gmane.org ([80.91.224.249]:56727 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265264AbUFAWYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:24:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Wed, 2 Jun 2004 00:23:24 +0200
Message-ID: <MPG.1b272042f54382879896b4@news.gmane.org>
References: <Pine.GSO.4.58.0406011105330.6922@stekt37> <20040530134246.GA1828@ucw.cz> <xb7n03n5iji.fsf@savona.informatik.uni-freiburg.de> <200406011318.36992.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-176-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> echo "rawdev" > /sys/bus/serio/devices/serio0/driver
> 
> or something alont these lines. At least that's my grand plan ;)

I like this kind of idea. Many options should be settable this 
way (think for example about Synaptics and ALPS touchpad 
configurations: whether to use multipointers separately or 
together, (de)activation of tapping, button remapping etc).

Yes, we need sysfs ...

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

