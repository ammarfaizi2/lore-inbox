Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUFKMUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUFKMUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 08:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUFKMUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 08:20:52 -0400
Received: from main.gmane.org ([80.91.224.249]:24485 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263868AbUFKMUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 08:20:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: touchpad (PS/2) mouse detection problem.
Date: Fri, 11 Jun 2004 14:20:36 +0200
Message-ID: <MPG.1b33c0a163d6f2e59896ca@news.gmane.org>
References: <40C8EA4B.7070604@enenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-143-131.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Garber ENEnet wrote:
> Hello,
> 
> I've compiled the 2.6.6 kernel, and I can't seem to get my laptops 
> touchpad to get detected.
> The touchpad runs on the ps/2 protocol; so it seems like there would be 
> no problems with
> detection. But of course I'm not a very lucky person ;-). The touchpad 
> itself does have an
> on/off botton; and I've made sure to keep it ON. This is a strange 
> problem because I don't
> seem to have it in older kernels (2.4.x). Cat'ing 
> /proc/bus/input/devices also doesn't turn up
> any useful information; just returns my keyboard (which works; yepi!). 
> I've compiled
> psmouse both into the kernel and as a module; both don't work.
> 
> dmesg only shows "mice: PS/2 mouse device common for all mice" but no 
> 'input:' line.

More info on the laptop mfgr/series/model and the touchpad 
type? Which input modules do you have, compiled in or as 
modules?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

