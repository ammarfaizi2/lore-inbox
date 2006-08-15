Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHOO5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHOO5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWHOO5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:57:14 -0400
Received: from bay0-omc3-s4.bay0.hotmail.com ([65.54.246.204]:45158 "EHLO
	bay0-omc3-s4.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932368AbWHOO5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:57:13 -0400
Message-ID: <BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
X-Originating-IP: [193.62.3.251]
X-Originating-Email: [lukesharkey@hotmail.co.uk]
In-Reply-To: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
From: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
To: dmitry.torokhov@gmail.com, andi@rhlx01.fht-esslingen.de, davej@redhat.com,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com,
       linux-kernel@vger.kernel.org, malattia@linux.it, lista1@comhem.se
Subject: Re: Touchpad problems with latest kernels
Date: Tue, 15 Aug 2006 15:57:05 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Aug 2006 14:57:09.0170 (UTC) FILETIME=[14F44120:01C6C07B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To all concerned,

thank you for your assistance.  I sent the previous message concerning my 
touchpad in order to provide some feedback for the developers of the 
drivers.

>What kind of touchpad is this?
A Synaptics PS/2 Port Touchpad.  The driver is "synaptics", according to 
hwbrowser.

>Can you please try vanilla kernels from kernel.org?
Regrettably, no.

Though I am the most technologically minded person I know, I am still many 
years from being a linux guru and should be considered a linux newbie.  
Compiling my own vanilla kernel is still beyond my scope as a linux user.  I 
use the precompiled .rpm kernels provided on the fedora download website.

Secondly, as I like to upgrade my kernel as often as possible in order to 
recieve the latest drivers for all my hardware, frequently compiling my own 
kernels compared to simply installing a ready made one would be too much of 
a burden upon my time.

>Can you please try vanilla kernels from kernel.org?
...Have I emailed the wrong address though?  Should I have contacted someone 
at redhat / working on the fedora project???

>In earlier kernels the issue _seemed_ to lessen if booting with i8042.nomux
Are you sure about this?  I mean, I wasn't having any problem at all with 
the 2054 kernel (sorry to use the fedora-kernel indexing system again).  It 
worked great.

>Unless someone establishes a contact with people at Synaptics or
>disassembles the win driver, linux will stay with the loony tunes...
But the driver was ok for the 2054 kernel.  Can't the driver for my touchpad 
be rolled back to the 2054 driver until this is fixed?  Right now the 
onscreen pointer is practically unusuable when I so much as open a konqueror 
window.  It frequently freezes on screen for many seconds.  (When I said it 
was jerky, I don't mean that it pings around all over the screen).



As I mentioned above, I only wished to alert somebody to the fact that 
support for my touchpad was actually getting *worse*; this shouldn't really 
happen.

(I'd stick with the older kernel except that the newer ones have the support 
for my bcm43xx wireless card, which though still quite temperamental, I 
need.)


Thank you,
LS

_________________________________________________________________
The new Windows Live Toolbar helps you guard against viruses 
http://toolbar.live.com/?mkt=en-gb

