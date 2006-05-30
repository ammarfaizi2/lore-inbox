Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWE3Xjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWE3Xjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWE3Xjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:39:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31212 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964830AbWE3Xjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:39:44 -0400
Date: Wed, 31 May 2006 01:38:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530233855.GF16106@elf.ucw.cz>
References: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com> <20060530202401.GC16106@elf.ucw.cz> <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com> <20060530233813.GC16521@fooishbar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530233813.GC16521@fooishbar.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 31-05-06 02:38:13, Daniel Stone wrote:
> On Tue, May 30, 2006 at 07:27:25PM -0400, Jon Smirl wrote:
> > On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> > >Actually the suspend/resume has to be in userspace, X just re-posts
> > >the video ROM and reloads the registers... so the repost on resume has
> > >to happen... so some component needs to be in userspace..
> > 
> > I'd like to see the simple video POST program get finished.
> 
> http://archive.ubuntu.com/ubuntu/pool/main/v/vbetool/

also integreted into cvs at suspend.sf.net, along with dmi-based
whitelist.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
