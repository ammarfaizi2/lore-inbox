Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVGKQ4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVGKQ4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGKQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:53:57 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:7328 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S262177AbVGKQxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:53:40 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Userspace accelerometer viewer)
From: Dave Hansen <dave@sr71.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Sladen <thinkpad@paul.sladen.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <1121092015.7407.68.camel@localhost.localdomain>
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
	 <1121092015.7407.68.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 09:53:31 -0700
Message-Id: <1121100811.15095.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 15:26 +0100, Alan Cox wrote:
> On Llu, 2005-07-11 at 10:42, Paul Sladen wrote:
> >   theta = (N - 512) * 0.5
> > 
> > provides a surprisingly good approximation for pitch/roll values in degrees
> > in the range (-90..+90) so I think the sensor can do ~= +/-2.5G .
> > 
> >   http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-screenshot.png (9kB)
> 
> Is the quality good enough to use it DEC itsy style as an input device
> for games like Marble madness ?

I was using it as a mouse as I tested interfacing it as an input device.
It could use some fine tuning, but it worked well enough for me to
navigate over to some icons.  Should be fine for games like that.

-- Dave

