Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRILVdM>; Wed, 12 Sep 2001 17:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271257AbRILVdC>; Wed, 12 Sep 2001 17:33:02 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7940 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S269693AbRILVc7>;
	Wed, 12 Sep 2001 17:32:59 -0400
Message-ID: <20010912122826.A6153@bug.ucw.cz>
Date: Wed, 12 Sep 2001 12:28:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Phil Thompson <Phil.Thompson@pace.co.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: User Space Emulation of Devices
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>; from Phil Thompson on Thu, Sep 06, 2001 at 09:25:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Without going into the gory details, I have a requirement for a device
> driver that does very little apart from pass on the open/close/read/write
> "requests" onto a user space application to implement and pass back to the
> driver.
> 
> Does anything like this already exist?

Something like that which would also pass ioctl()s would be *very*
welcome.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
