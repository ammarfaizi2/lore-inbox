Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbRJBVaX>; Tue, 2 Oct 2001 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276703AbRJBVaN>; Tue, 2 Oct 2001 17:30:13 -0400
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276702AbRJBV36>;
	Tue, 2 Oct 2001 17:29:58 -0400
Message-ID: <20011002213833.B140@bug.ucw.cz>
Date: Tue, 2 Oct 2001 21:38:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stephane Dudzinski <stephane@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: USB Issues on 2.4
In-Reply-To: <1001935474.17479.25.camel@steph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <1001935474.17479.25.camel@steph>; from Stephane Dudzinski on Mon, Oct 01, 2001 at 12:24:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would like to bring your attention to some USB issues i experienced
> with a USB mouse and normal PS/2 keyboard (not USB).
> 
> I installed a usb mouse on 2 systems, one being a pure intel with an
> i810 chipset and the other being a via 686b chipset.
> 
> First one (the intel) behaves fine, all modules loading up okay and all
> working smoothly.
> 
> Second one (via from hell) locks up the keyboard as soon as the usb-uhci
> is loaded up. This behavior happened on both 2.4.9 and 2.4.10 final
> kernels.

USB legacy emulation, where firmware emulates ps/2 mouse from usb one?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
