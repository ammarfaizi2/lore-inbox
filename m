Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263907AbRFIWxI>; Sat, 9 Jun 2001 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263908AbRFIWw6>; Sat, 9 Jun 2001 18:52:58 -0400
Received: from erasmus.off.net ([64.39.30.25]:33808 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S263907AbRFIWwx>;
	Sat, 9 Jun 2001 18:52:53 -0400
Date: Sat, 9 Jun 2001 18:52:40 -0400
From: Zach Brown <zab@zabbo.net>
To: Ben Pfaff <pfaffben@msu.edu>
Cc: Lukas Schroeder <lukas@edeal.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ess maestro, support for hardware volume control
Message-ID: <20010609185240.A23980@erasmus.off.net>
In-Reply-To: <200106091931.f59JVw731673@devserv.devel.redhat.com> <87elst2vr2.fsf@pfaffben.user.msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <87elst2vr2.fsf@pfaffben.user.msu.edu>; from pfaffben@msu.edu on Sat, Jun 09, 2001 at 05:23:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I now have a patch that will output the hwv buttons pressed (up,
> down, mute) to a new dynamically allocated misc device as letters
> u, d, m, instead of directly modifying the mixer.  Anyone want
> that?  It's more flexible than either the patch that's currently
> in -ac or Lukas's patch, but you need a little userspace daemon
> for it to do anything useful.

hmm.. how do the alsa guys deal with hw volume?  I'm not sure I like
adding more stuff to the OSS API.  

-- 
 zach
