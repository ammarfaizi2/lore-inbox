Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbTCZNrQ>; Wed, 26 Mar 2003 08:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbTCZNrQ>; Wed, 26 Mar 2003 08:47:16 -0500
Received: from pc2-bahd1-3-cust72.renf.cable.ntl.com ([62.255.161.72]:64875
	"EHLO localhost") by vger.kernel.org with ESMTP id <S261695AbTCZNrN>;
	Wed, 26 Mar 2003 08:47:13 -0500
Date: Wed, 26 Mar 2003 13:58:25 +0000
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: addition to visor.c
Message-ID: <20030326135825.GC26063@localhost>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030326021847.GA21363@localhost> <20030326040505.GB20858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326040505.GB20858@kroah.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.4.20 (i686)
X-Uptime: 13:55:51 up  2:53,  3 users,  load average: 0.20, 0.37, 0.47
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Mar 26, 2003 at 02:18:47AM +0000, iain d broadfoot wrote:
> > First off, hi all and thanks for all the kernels. :D
> > 
> > I have fiddled together the following info for a sony clie nz90, which i
> > believe should go in drivers/usb/serial/visor.{h,c}.
> 
> Thanks, but this device is already supported in the latest 2.5 kernel :)

ah. ok-dok. :(

i felt so proud and manly and super-cool as well...

> 
> And it's in my queue of patches to send to Marcelo for 2.4, so it will
> show up there too eventually.

sweet.

i just need to remember not to bunzip the kernel source over my version
now...

> 
> > ok, it recognizes, but none of the apps i have seem to like the clie - i
> > get 'please press hotsync button now' messages, despite the fact that
> > the /dev/ttyUSB1 device is only there after the button has been
> > pressed... :(
> 
> Try the latest version of pilot-link, from pilot-link.org.  You need
> that.  If that doesn't work, try ttyUSB0, that might be the correct port
> for this device.

hmm, i've got the latest pilot-link, and i've tried both 0 and 1 (0 gets
logged as the Generic, while 1 is logged as HotSync) so i think it's
time to find a new list to harass. :D

cheers,

iain

-- 
wh33, y1p33 3tc.
