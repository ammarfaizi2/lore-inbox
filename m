Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTEOMeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 08:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTEOMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 08:34:20 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:57071 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263985AbTEOMeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:34:20 -0400
Subject: Re: [dri] x startup hangs again... ~2.5.69-bk5
From: Martin Schlemmer <azarah@gentoo.org>
To: Andreas Happe <andreashappe@gmx.net>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnbc427q.377.andreashappe@flatline.ath.cx>
References: <slrnbc25b6.e5.andreashappe@flatline.ath.cx>
	 <20030513165647.GA1056@suse.de>
	 <slrnbc2d9s.cv.andreashappe@flatline.ath.cx>
	 <slrnbc427q.377.andreashappe@flatline.ath.cx>
Content-Type: text/plain
Organization: 
Message-Id: <1053002472.9778.78.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 15 May 2003 14:41:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 11:14, Andreas Happe wrote:

> I've changed the settings around 2.5.69 because i've tried to get the
> linux neverwinter nights client running smoother and have forgotten to
> remove it from the config file. I must have been lucky until 2.5.69-bk5
> which started to crash my system (so there isn't a regression, just a
> "normal" instability (of which i have been warned...).
> 

I am not so sure.  I have a geforce3 ti5, that has been running fine
with nvidia drivers 1.0.4363 (yes, I know they are not supported here).

Thing is, until 2.5.69-bk1/2/3, it have been running fine, and with
bk7/8, I have had X dieing when just scrolling a window in evolution
or galeon.  This is usually if it had been up for a few hours.

Thus, basically with the same drivers/X/whatever, it has been
working fine for day no reboot, but somewhere after bk3 something
is causing it to misbehave.

The mobo is a Asus P4C800 (Intel 875p chipset), with the agp running
in 4x mode.


Regards,

-- 
Martin Schlemmer


