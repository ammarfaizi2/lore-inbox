Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264023AbRFHPvO>; Fri, 8 Jun 2001 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbRFHPvF>; Fri, 8 Jun 2001 11:51:05 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262168AbRFHPuq>;
	Fri, 8 Jun 2001 11:50:46 -0400
Date: Wed, 6 Jun 2001 23:21:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010606232133.E38@toy.ucw.cz>
In-Reply-To: <20010606125556.A1766@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010606125556.A1766@suse.cz>; from vojtech@suse.cz on Wed, Jun 06, 2001 at 12:55:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> If you still have your 3-button MouseSystems (or any other serial) mouse
> somewhere in your driver, forgotten becase of the incredibly slow update
> rate causing so much jumping of the pointer on the screen that it is
> unusable, you may want to pull it out and give it a try.
> 
> Or if you're still using it with some old 486 computer, this driver is
> for you. 
> 
> What it does is that it enhances the update rate from 24 (with current
> GPM and X drivers) to 96. This is almost what the best USB mice do.

What's the "prediction" stuff? Does it mean you are guessing some values
by interpolation? [If so, what kind of update rate would it do on USB?]
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

