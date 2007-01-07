Return-Path: <linux-kernel-owner+w=401wt.eu-S965251AbXAGXom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbXAGXom (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbXAGXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:44:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2821 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965258AbXAGXol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:44:41 -0500
Date: Mon, 8 Jan 2007 00:44:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070107234445.GM20714@stusta.de>
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107222706.GA6092@thinkpad.home.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:27:06PM +0100, Tino Keitel wrote:
> On Sun, Jan 07, 2007 at 21:04:53 +0100, Tino Keitel wrote:
> > On Sun, Jan 07, 2007 at 13:23:13 -0500, Lee Revell wrote:
> > > On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> > > > No information about the device/driver that refuses to resume.
> > > 
> > > You should be able to identify the problematic driver by removing each
> > > driver manually before suspending.
> > 
> > I can not reproduce it anymore, resume now works. I really hope that it
> > will stay so.
> 
> It didn't. It looks like it is unusable, becuase it isn't reliable in
> 2.6.20-rc3.

Is this issue still present in -rc4?

> Regards,
> Tino

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

