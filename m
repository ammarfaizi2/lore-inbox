Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVGKOdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVGKOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGKOay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:30:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53197 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261839AbVGKOaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:30:25 -0400
Subject: Re: [ltp] IBM HDAPS Someone interested? (Userspace accelerometer
	viewer)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Sladen <thinkpad@paul.sladen.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121092015.7407.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 15:26:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-07-11 at 10:42, Paul Sladen wrote:
>   theta = (N - 512) * 0.5
> 
> provides a surprisingly good approximation for pitch/roll values in degrees
> in the range (-90..+90) so I think the sensor can do ~= +/-2.5G .
> 
>   http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-screenshot.png (9kB)

Is the quality good enough to use it DEC itsy style as an input device
for games like Marble madness ?

